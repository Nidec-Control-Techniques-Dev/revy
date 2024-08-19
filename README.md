# revy

An internal tool to boost salespeople's productivity

## Google Maps APIs not working?

Check if Google API keys are valid.

Resources to check out if API keys need to be modified:
- [envied package](https://pub.dev/packages/envied)
- [google_maps_flutter](https://pub.dev/packages/google_maps_flutter)

### Worried about your API keys being leaked from the manifest?
- [See top answer](https://stackoverflow.com/questions/59473527/how-to-hide-api-keys-in-androidmanifest-xml)


## TO-DO LIST
- Staged companies (companies selected during schedule algorithm) must be offloaded as available companies after some period
  - Current solution: all staged companies are offloaded everytime a schedule is saved
  - Drawbacks: it is still possible for companies to be chosen in more than one schedule (we want schedules to be non-overlapping)
- Create backend and frontend to create new users (sales and admins)
  - For new sales users, during creation they must be assigned a country/s, states/s, business model/s, category/s
  - For new admins, during creation, they must be assigned salespeople.
- Feedback page
- Report an issue page
- Improve Mobile App UI/UX
- Improve scheduling algorithm
