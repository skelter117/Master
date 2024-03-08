def clean_input(input_str):
  cleaned_input = input_str.replace("$", "").replace(",", "").replace(" ", "").replace("dollars", "")
  return cleaned_input

AssetValueInput = input("Enter the Asset Value: ")
AssetValueInput = clean_input(AssetValueInput)
AssetValue = float(AssetValueInput)

ExposureFactorInput = input("Enter the Exposure Factor: ")
if ExposureFactorInput.endswith("%"):
  ExposureFactorInput = ExposureFactorInput[:-1]
ExposureFactor = float(ExposureFactorInput)
ExposureFactorPercentage = ExposureFactor / 100

SingleLossExpectancy = AssetValue * ExposureFactorPercentage
print("Your single loss expectancy is: $", SingleLossExpectancy)

AnnualizedRateOfOccurrenceInput = input("Enter the Annualized Rate of Occurrence: ")
AnnualizedRateOfOccurrenceInput = clean_input(AnnualizedRateOfOccurrenceInput)
if AnnualizedRateOfOccurrenceInput.endswith("%"):
  AnnualizedRateOfOccurrenceInput = AnnualizedRateOfOccurrenceInput[:-1]
AnnualizedRateOfOccurrence = float(AnnualizedRateOfOccurrenceInput) / 100  
AnnualLossExpectancy = SingleLossExpectancy * AnnualizedRateOfOccurrence
print("Your annual loss expectancy is: $", AnnualLossExpectancy)

if AnnualLossExpectancy < 10000:
  print("Low Risk")
elif 10001 <= AnnualLossExpectancy <= 50000:
  print("Medium Risk")
else:
  print("High Risk")
