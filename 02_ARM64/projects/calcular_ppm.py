ADC_MAX = 1023
VCC = 3.3
VCC_SENSOR = 5.0
RL = 10000

def adc_a_voltaje(adc_value):
    return (adc_value / ADC_MAX) * VCC

def voltaje_a_resistencia(vout):
    if vout <= 0:
        return float('inf')

    rs = RL * ((VCC_SENSOR / vout) - 1)
    return rs

# Aire limpio: 400 ppm
# Aire contaminado: 2000 ppm
def rs_to_ro(rs):
    return rs / 3.6


def rs_ro_to_ppm(rs, ro):
    if ro <= 0:
        return 0

    ratio = rs / ro
    A = 116.6020682
    B = -2.769034857

    ppm = A * (ratio ** B)
    return ppm


adc_value = 1023
voltaje = adc_a_voltaje(adc_value)
resistencia = voltaje_a_resistencia(voltaje)

# Calibración: Rs/Ro = 3.6 en aire limpio (400 ppm)
ro = 10000

ppm_co2 = rs_ro_to_ppm(resistencia, ro)

print(f"ADC Value: {adc_value}")
print(f"Voltaje: {voltaje:.2f} V")
print(f"Resistencia del sensor: {resistencia:.2f} ohmios")
print(f"Concentración de CO2: {ppm_co2:.2f} ppm")

