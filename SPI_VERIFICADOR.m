clear;
clc;
close all;

% =========================================================
% CONFIGURACIÓN
% =========================================================
archivoCSV = "senal_ppg_12000s.csv";

% Leer datos guardados por el programa anterior
datos = readtable(archivoCSV);

t = datos.t;
senalCruda = datos.senalCruda;

% Usar señal ya suavizada si está en el CSV
if ismember("senalPPG", datos.Properties.VariableNames)
    senalPPG = datos.senalPPG;
else
    senalPPG = movmean(senalCruda, 5);
end

% =========================================================
% DETECTAR PICOS Y VALLES
% =========================================================
[indPicos, indValles] = metodoAlpinista(senalPPG);

% =========================================================
% CÁLCULO DE SPI PARA CADA LATIDO
%
% PPGA = Pico sistólico - valle anterior
% HBI  = Tiempo entre dos picos consecutivos
% SPI  = 100 - (0.7 * PPGAnorm + 0.3 * HBInorm)
% =========================================================
ppga = [];
hbi = [];
tiempoSPI = [];

% Se inicia en el segundo pico porque HBI necesita un pico anterior
for k = 2:length(indPicos)

    picoActual = indPicos(k);
    picoAnterior = indPicos(k - 1);

    % Buscar valles entre el pico anterior y el pico actual
    vallesDelLatido = indValles( ...
        indValles > picoAnterior & indValles < picoActual);

    % Si no hay uno entre ambos, buscar el último valle previo
    if isempty(vallesDelLatido)
        vallesDelLatido = indValles(indValles < picoActual);
    end

    if ~isempty(vallesDelLatido)

        vallePrevio = vallesDelLatido(end);

        % Amplitud de la onda PPG para este latido
        amplitudPulso = senalPPG(picoActual) - senalPPG(vallePrevio);

        % Intervalo entre latidos para este latido
        intervaloLatidos = t(picoActual) - t(picoAnterior);

        if amplitudPulso > 0 && intervaloLatidos > 0
            ppga(end+1, 1) = amplitudPulso;
            hbi(end+1, 1) = intervaloLatidos;
            tiempoSPI(end+1, 1) = t(picoActual);
        end
    end
end

% =========================================================
% NORMALIZAR Y CALCULAR SPI POR LATIDO
% =========================================================
if length(ppga) >= 2

    % Normalización entre 0 y 100
    if max(ppga) ~= min(ppga)
        PPGAnorm = 100 * (ppga - min(ppga)) / (max(ppga) - min(ppga));
    else
        PPGAnorm = zeros(size(ppga));
    end

    if max(hbi) ~= min(hbi)
        HBInorm = 100 * (hbi - min(hbi)) / (max(hbi) - min(hbi));
    else
        HBInorm = zeros(size(hbi));
    end

    % Un valor SPI para cada latido
    SPI = 100 - (0.7 * PPGAnorm + 0.3 * HBInorm);

else
    error("No se detectaron suficientes latidos para calcular SPI.");
end

% =========================================================
% GUARDAR RESULTADOS POR LATIDO
% =========================================================
resultadosSPI = table(tiempoSPI, ppga, hbi, PPGAnorm, HBInorm, SPI);

writetable(resultadosSPI, "spi_por_latido.csv");

disp("Archivo guardado: spi_por_latido.csv");

% =========================================================
% GRÁFICAS
% =========================================================
figure('Color', 'w', 'Name', 'PPG y SPI por latido');

% Señal PPG cruda
subplot(3,1,1);
plot(t, senalCruda, 'Color', [0.35 0.35 0.35]);
grid on;
xlabel('Tiempo (s)');
ylabel('ADC');
title('Señal PPG cruda');
ylim([1900 2120]);

% Señal PPG con picos y valles
subplot(3,1,2);
plot(t, senalPPG, 'b', 'LineWidth', 1.1);
hold on;

plot(t(indPicos), senalPPG(indPicos), ...
    'rv', 'MarkerFaceColor', 'r', 'MarkerSize', 7);

plot(t(indValles), senalPPG(indValles), ...
    'go', 'MarkerFaceColor', 'g', 'MarkerSize', 5);

grid on;
xlabel('Tiempo (s)');
ylabel('ADC suavizado');
title('Picos sistólicos y valles detectados');
legend('PPG suavizada', 'Picos sistólicos', 'Valles', ...
    'Location', 'best');
ylim([1900 2120]);

% SPI para cada latido
subplot(3,1,3);
plot(tiempoSPI, SPI, '-mo', ...
    'LineWidth', 1.2, ...
    'MarkerFaceColor', 'm', ...
    'MarkerSize', 5);

grid on;
xlabel('Tiempo (s)');
ylabel('SPI');
title('SPI calculado para cada latido');
ylim([0 100]);


% =========================================================
% FUNCIÓN: Método del Alpinista
% =========================================================
function [picos, valles] = metodoAlpinista(senal)

    N = length(senal);

    umbral = 6;
    numSubidas = 0;

    posiblePico = false;
    posibleValle = false;

    valorPosiblePico = 0;
    indicePosiblePico = 0;

    valorPosibleValle = 0;
    indicePosibleValle = 0;

    picos = [];
    valles = [];

    for i = 2:N

        if senal(i) > senal(i-1)

            numSubidas = numSubidas + 1;

            if ~posibleValle
                posibleValle = true;
                valorPosibleValle = senal(i-1);
                indicePosibleValle = i-1;
            end

        else

            if numSubidas >= umbral
                posiblePico = true;
                valorPosiblePico = senal(i-1);
                indicePosiblePico = i-1;

            else
                if posibleValle && senal(i) <= valorPosibleValle
                    valorPosibleValle = senal(i);
                    indicePosibleValle = i;
                end
            end

            if posiblePico

                if senal(i-1) > valorPosiblePico
                    indicePicoFinal = i-1;
                else
                    indicePicoFinal = indicePosiblePico;
                end

                picos = [picos; indicePicoFinal];

                if posibleValle
                    valles = [valles; indicePosibleValle];
                    posibleValle = false;
                end

                umbral = 0.6 * numSubidas;
                posiblePico = false;
            end

            numSubidas = 0;
        end
    end
end