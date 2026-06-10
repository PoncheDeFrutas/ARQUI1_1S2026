VCC = 3.3
ADC_MAX = 1023
R_FIJA = 10000

def adc_a_voltaje(adc_value):
    return (adc_value / ADC_MAX) * VCC

def voltaje_a_resistencia(vout):
    if vout < 0:
        return 0
    elif vout >= VCC:
        return float('inf')

    r_ldr = R_FIJA * vout / (VCC - vout)
    return r_ldr

def resistencia_a_lux(r_ldr):
    if r_ldr <= 0:
        return 0

    A = 500
    B = -1.4

    lux = A * (r_ldr / 1000) ** B
    return lux

adc_value = 512

voltaje = adc_a_voltaje(adc_value)
resistencia = voltaje_a_resistencia(voltaje)
lux = resistencia_a_lux(resistencia)
print(f"Voltaje: {voltaje} V")
print(f"Resistencia del LDR: {resistencia:.2f} ohmios")
print(f"Iluminancia: {lux:.2f} lux")
