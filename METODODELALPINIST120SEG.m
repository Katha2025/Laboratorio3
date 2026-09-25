
clear;
clc;
close all;

% ---------- Configuración ----------
puerto = "COM6";
baudios = 115200;
fs = 100;                  % Hz, igual que el ESP
duracion = 120;             % segundos
N = fs * duracion;         % 3000 muestras

% ---------- Conexión con ESP ----------
esp = serialport(puerto, baudios);
configureTerminator(esp, "LF");
esp.Timeout = 5;

pause(2);                  % Esperar a que el ESP reinicie
flush(esp);                % Eliminar datos anteriores

senalCruda = zeros(N, 1);

disp("Grabando señal PPG durante 30 segundos...");
disp("Mantén el dedo quieto sobre el sensor.");

% ---------- Adquisición ----------
muestra = 1;

while muestra <= N
    linea = readline(esp);
    valor = str2double(strtrim(linea));

    % Guardar solo líneas numéricas válidas
    if ~isnan(valor)
        senalCruda(muestra) = valor;
        muestra = muestra + 1;
    end
end

clear esp;

disp("Adquisición terminada. Procesando señal...");

% Tiempo de cada muestra
t = (0:N-1)' / fs;

% Suavizado leve para eliminar ruido rápido
% No cambia la lógica del método del alpinista
senalPPG = movmean(senalCruda, 5);

% ---------- Método del Alpinista ----------
[indPicos, indValles] = metodoAlpinista(senalPPG);

% Calcular frecuencia cardiaca aproximada
if length(indPicos) >= 2
    intervalosRR = diff(t(indPicos));
    FC = 60 / mean(intervalosRR);
    fprintf("Frecuencia cardiaca estimada: %.1f lpm\n", FC);
else
    fprintf("No se detectaron suficientes picos para calcular FC.\n");
end

% ---------- Gráficas ----------
figure('Color', 'w', 'Name', 'PPG - Método del Alpinista');

subplot(2,1,1)
plot(t, senalCruda, 'Color', [0.3 0.3 0.3]);
grid on;
xlabel('Tiempo (s)');
ylabel('ADC');
title('Señal PPG cruda adquirida desde ESP32-S3');

subplot(2,1,2)
plot(t, senalPPG, 'b', 'LineWidth', 1.2);
hold on;

plot(t(indPicos), senalPPG(indPicos), ...
    'rv', 'MarkerFaceColor', 'r', 'MarkerSize', 7);

plot(t(indValles), senalPPG(indValles), ...
    'go', 'MarkerFaceColor', 'g', 'MarkerSize', 5);

grid on;
xlabel('Tiempo (s)');
ylabel('ADC suavizado');
title('Método del Alpinista: picos sistólicos y valles');
legend('PPG suavizada', 'Picos sistólicos', 'Valles', ...
    'Location', 'best');

% Guardar datos
datosPPG = table(t, senalCruda, senalPPG);
writetable(datosPPG, 'senal_ppgs.csv');

disp("Archivo guardado: senal_ppgs.csv");


% =========================================================
% FUNCIÓN: Método del Alpinista (MMPD)
% Basado en el artículo proporcionado
% =========================================================
function [picos, valles] = metodoAlpinista(senal)

    N = length(senal);

    umbral = 6;            % Umbral inicial del artículo
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

        % Si la señal sube
        if senal(i) > senal(i-1)

            numSubidas = numSubidas + 1;

            % Inicio de una posible subida: posible valle
            if ~posibleValle
                posibleValle = true;
                valorPosibleValle = senal(i-1);
                indicePosibleValle = i-1;
            end

        % Si la señal deja de subir
        else

            % La subida fue suficientemente larga:
            % posible pico sistólico
            if numSubidas >= umbral
                posiblePico = true;
                valorPosiblePico = senal(i-1);
                indicePosiblePico = i-1;

            else
                % Buscar el punto más bajo del posible valle
                if posibleValle
                    if senal(i) <= valorPosibleValle
                        valorPosibleValle = senal(i);
                        indicePosibleValle = i;
                    end
                end
            end

            % Confirmar pico encontrado
            if posiblePico

                if senal(i-1) > valorPosiblePico
                    indicePicoFinal = i-1;
                else
                    indicePicoFinal = indicePosiblePico;
                end

                picos = [picos; indicePicoFinal];

                % Guardar el valle anterior al pico
                if posibleValle
                    valles = [valles; indicePosibleValle];
                    posibleValle = false;
                end

                % Actualizar umbral: 60 % de las subidas previas
                umbral = 0.6 * numSubidas;

                posiblePico = false;
            end

            % Reiniciar contador al terminar una subida
            numSubidas = 0;
        end
    end
end