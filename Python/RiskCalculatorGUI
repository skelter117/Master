import tkinter as tk
from tkinter.simpledialog import askstring
from tkinter import messagebox

def clean_input(input_str):
    cleaned_input = input_str.replace("$", "").replace(",", "").replace(" ", "").replace("dollars", "")
    return cleaned_input

window = tk.Tk()
window.title("Risk Analysis")
window.geometry("800x700")
window.configure(bg="black")

AssetValueInput = askstring("Calculator", "Enter the Asset Value: ")
AssetValueInput = clean_input(AssetValueInput)
AssetValue = float(AssetValueInput)

ExposureFactorInput = askstring("Calculator", "Enter the Exposure Factor: ")
if ExposureFactorInput.endswith("%"):
    ExposureFactorInput = ExposureFactorInput[:-1]
ExposureFactor = float(ExposureFactorInput)
ExposureFactorPercentage = ExposureFactor / 100

SingleLossExpectancy = AssetValue * ExposureFactorPercentage

AnnualizedRateOfOccurrenceInput = askstring("Calculator", f"Single Loss Expectancy: ${SingleLossExpectancy:2f}, \nEnter the Annualized Rate of Occurrence:")
if AnnualizedRateOfOccurrenceInput.endswith("%"):
    AnnualizedRateOfOccurrenceInput = AnnualizedRateOfOccurrenceInput[:-1]
AnnualizedRateOfOccurrence = float(AnnualizedRateOfOccurrenceInput) / 100

AnnualLossExpectancy = SingleLossExpectancy * AnnualizedRateOfOccurrence

if AnnualLossExpectancy < 10000:
    RiskLevel = "Low Risk"
elif 10001 <= AnnualLossExpectancy <= 50000:
    RiskLevel = "Medium Risk"
else:
    RiskLevel = "High Risk"

message = f"Annual Loss Expectancy is:\n${AnnualLossExpectancy}\n\nRisk Level: {RiskLevel}"
messagebox.showinfo("Calculator", message)

window.mainloop()
