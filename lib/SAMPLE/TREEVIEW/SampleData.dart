import 'dart:convert';

const List<Map<String, dynamic>> SampleData = [
  {
    "label": "A",
    "key": "A",
    "children": [
      {"label": "Alabama", "key": "AL", "fullPath":""},
      {"label": "Alaska", "key": "AK", "fullPath":""},
      {"label": "American Samoa", "key": "AS", "fullPath":""},
      {"label": "Arizonaa", "key": "AZ2", "children":
        [
        ]
        , "fullPath":""
      },
      {"label": "Arkansas", "key": "AR3", "children":
        [
          {"label": "California", "key": "CA4", "fullPath":""},
          {"label": "Colorado", "key": "CO5", "fullPath":""},
          {"label": "Connecticut", "key": "CT6", "fullPath":""},
        ]
        , "fullPath":""
      }
    ]
  },
  {
    "label": "C",
    "key": "C",
    "children": [
      {"label": "California", "key": "CA", "fullPath":""},
      {"label": "Colorado", "key": "CO", "fullPath":""},
      {"label": "Connecticut", "key": "CT", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "D",
    "key": "D",
    "children": [
      {"label": "Delaware", "key": "DE", "fullPath":""},
      {"label": "District Of Columbia", "key": "DC", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "F",
    "key": "F",
    "children": [
      {"label": "Federated States Of Micronesia", "key": "FM", "fullPath":""},
      {"label": "Florida", "key": "FL", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "G",
    "key": "G",
    "children": [
      {"label": "Georgia", "key": "GA", "fullPath":""},
      {"label": "Guam", "key": "GU", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "H",
    "key": "H",
    "children": [
      {"label": "Hawaii", "key": "HI", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "I",
    "key": "I",
    "children": [
      {"label": "Idaho", "key": "ID", "fullPath":""},
      {"label": "Illinois", "key": "IL", "fullPath":""},
      {"label": "Indiana", "key": "IN", "fullPath":""},
      {"label": "Iowa", "key": "IA", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "K",
    "key": "K",
    "children": [
      {"label": "Kansas", "key": "KS", "fullPath":""},
      {"label": "Kentucky", "key": "KY", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "L",
    "key": "L",
    "children": [
      {"label": "Louisiana", "key": "LA", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "M",
    "key": "M",
    "children": [
      {"label": "Maine", "key": "ME", "fullPath":""},
      {"label": "Marshall Islands", "key": "MH", "fullPath":""},
      {"label": "Maryland", "key": "MD", "fullPath":""},
      {"label": "Massachusetts", "key": "MA", "fullPath":""},
      {"label": "Michigan", "key": "MI", "fullPath":""},
      {"label": "Minnesota", "key": "MN", "fullPath":""},
      {"label": "Mississippi", "key": "MS", "fullPath":""},
      {"label": "Missouri", "key": "MO", "fullPath":""},
      {"label": "Montana", "key": "MT", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "N",
    "key": "N",
    "children": [
      {"label": "Nebraska", "key": "NE", "fullPath":""},
      {"label": "Nevada", "key": "NV", "fullPath":""},
      {"label": "New Hampshire", "key": "NH", "fullPath":""},
      {"label": "New Jersey", "key": "NJ", "fullPath":""},
      {"label": "New Mexico", "key": "NM", "fullPath":""},
      {"label": "New York", "key": "NY", "fullPath":""},
      {"label": "North Carolina", "key": "NC", "fullPath":""},
      {"label": "North Dakota", "key": "ND", "fullPath":""},
      {"label": "Northern Mariana Islands", "key": "MP", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "O",
    "key": "O",
    "children": [
      {"label": "Ohio", "key": "OH", "fullPath":""},
      {"label": "Oklahoma", "key": "OK", "fullPath":""},
      {"label": "Oregon", "key": "OR", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "P",
    "key": "P",
    "children": [
      {"label": "Palau", "key": "PW", "fullPath":""},
      {"label": "Pennsylvania", "key": "PA", "fullPath":""},
      {"label": "Puerto Rico", "key": "PR", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "R",
    "key": "R",
    "children": [
      {"label": "Rhode Island", "key": "RI", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "S",
    "key": "S",
    "children": [
      {"label": "South Carolina", "key": "SC", "fullPath":""},
      {"label": "South Dakota", "key": "SD", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "T",
    "key": "T",
    "children": [
      {"label": "Tennessee", "key": "TN", "fullPath":""},
      {"label": "Texas", "key": "TX", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "U",
    "key": "U",
    "children": [
      {"label": "Utah", "key": "UT", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "V",
    "key": "V",
    "children": [
      {"label": "Vermont", "key": "VT", "fullPath":""},
      {"label": "Virgin Islands", "key": "VI", "fullPath":""},
      {"label": "Virginia", "key": "VA", "fullPath":""},
    ]
    , "fullPath":""
  },
  {
    "label": "W",
    "key": "W",
    "children": [
      {"label": "Washington", "key": "WA", "fullPath":""},
      {"label": "West Virginia", "key": "WV", "fullPath":""},
      {"label": "Wisconsin", "key": "WI", "fullPath":""},
      {"label": "Wyoming", "key": "WY", "fullPath":""}
    ]
    , "fullPath":""
  },
];

String US_STATES_JSON = jsonEncode(SampleData);