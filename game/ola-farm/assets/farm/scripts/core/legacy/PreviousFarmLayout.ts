// Geometry used by building-layout v1 saves. Do not regenerate from the current map.
import { FarmLayoutManifest } from '../BuildingGeometry';
export const PREVIOUS_FARM_LAYOUT: FarmLayoutManifest = {
  version: 1,
  snap: {
    x: 36,
    y: 18,
  },
  bounds: {
    left: -830,
    right: 1320,
    bottom: -1030,
    top: 765,
    radius: 300,
  },
  buildings: [
    {
      id: 'farm-house',
      name: 'Nhà',
      kind: 'facility',
      node: 'MainObject-nha',
      position: {
        x: -412,
        y: 362,
      },
      footprints: [
        [
          {
            x: 0,
            y: -48,
          },
          {
            x: 130,
            y: -103,
          },
          {
            x: 0,
            y: -158,
          },
          {
            x: -130,
            y: -103,
          },
        ],
        [
          {
            x: -140,
            y: -50,
          },
          {
            x: -110,
            y: -75,
          },
          {
            x: -140,
            y: -100,
          },
          {
            x: -170,
            y: -75,
          },
        ],
      ],
      entrance: {
        x: -95,
        y: -145,
      },
      depthOffset: -103,
    },
    {
      id: 'barn',
      name: 'Kho',
      kind: 'facility',
      node: 'MainObject-kho',
      position: {
        x: -85,
        y: 430,
      },
      footprints: [
        [
          {
            x: 0,
            y: 2.5,
          },
          {
            x: 92.5,
            y: -40,
          },
          {
            x: 0,
            y: -82.5,
          },
          {
            x: -92.5,
            y: -40,
          },
        ],
      ],
      entrance: {
        x: 0,
        y: -108,
      },
      depthOffset: -40,
    },
    {
      id: 'pen:12',
      name: 'Chuồng gà',
      kind: 'pen',
      node: 'Cell12',
      position: {
        x: 255,
        y: 35,
      },
      footprints: [
        [
          {
            x: 0,
            y: 40,
          },
          {
            x: 80,
            y: -5,
          },
          {
            x: 0,
            y: -50,
          },
          {
            x: -80,
            y: -5,
          },
        ],
      ],
      entrance: {
        x: 45,
        y: 65,
      },
      depthOffset: 0,
    },
    {
      id: 'pen:13',
      name: 'Chuồng bò',
      kind: 'pen',
      node: 'Cell13',
      position: {
        x: 90,
        y: 115,
      },
      footprints: [
        [
          {
            x: 0,
            y: 42.5,
          },
          {
            x: 85,
            y: -5,
          },
          {
            x: 0,
            y: -52.5,
          },
          {
            x: -85,
            y: -5,
          },
        ],
      ],
      entrance: {
        x: -50,
        y: 65,
      },
      depthOffset: 0,
    },
    {
      id: 'bakery-1',
      name: 'Lò bánh',
      kind: 'machine',
      node: 'bakery-1',
      position: {
        x: 680,
        y: 140,
      },
      footprints: [
        [
          {
            x: 0,
            y: 70,
          },
          {
            x: 100,
            y: 20,
          },
          {
            x: 0,
            y: -30,
          },
          {
            x: -100,
            y: 20,
          },
        ],
      ],
      entrance: {
        x: 0,
        y: -90,
      },
      depthOffset: 0,
    },
    {
      id: 'dairy-1',
      name: 'Xưởng sữa',
      kind: 'machine',
      node: 'dairy-1',
      position: {
        x: 890,
        y: -80,
      },
      footprints: [
        [
          {
            x: 0,
            y: 70,
          },
          {
            x: 100,
            y: 20,
          },
          {
            x: 0,
            y: -30,
          },
          {
            x: -100,
            y: 20,
          },
        ],
      ],
      entrance: {
        x: 0,
        y: -90,
      },
      depthOffset: 0,
    },
    {
      id: 'feed-1',
      name: 'Máy thức ăn',
      kind: 'machine',
      node: 'feed-1',
      position: {
        x: 1040,
        y: -300,
      },
      footprints: [
        [
          {
            x: 0,
            y: 70,
          },
          {
            x: 100,
            y: 20,
          },
          {
            x: 0,
            y: -30,
          },
          {
            x: -100,
            y: 20,
          },
        ],
      ],
      entrance: {
        x: 0,
        y: -90,
      },
      depthOffset: 0,
    },
    {
      id: 'grill-1',
      name: 'Bếp nướng',
      kind: 'machine',
      node: 'grill-1',
      position: {
        x: 1050,
        y: 150,
      },
      footprints: [
        [
          {
            x: 0,
            y: 70,
          },
          {
            x: 100,
            y: 20,
          },
          {
            x: 0,
            y: -30,
          },
          {
            x: -100,
            y: 20,
          },
        ],
      ],
      entrance: {
        x: 0,
        y: -90,
      },
      depthOffset: 0,
    },
    {
      id: 'industry-pie_bakery',
      name: 'Tiệm Bánh Pie',
      kind: 'machine',
      node: 'industry-pie_bakery',
      position: {
        x: 800,
        y: -810,
      },
      footprints: [
        [
          {
            x: 0,
            y: 70,
          },
          {
            x: 100,
            y: 20,
          },
          {
            x: 0,
            y: -30,
          },
          {
            x: -100,
            y: 20,
          },
        ],
      ],
      entrance: {
        x: 0,
        y: -90,
      },
      depthOffset: 0,
    },
    {
      id: 'industry-popcorn_factory',
      name: 'Lò Ngô',
      kind: 'machine',
      node: 'industry-popcorn_factory',
      position: {
        x: 1040,
        y: -540,
      },
      footprints: [
        [
          {
            x: 0,
            y: 70,
          },
          {
            x: 100,
            y: 20,
          },
          {
            x: 0,
            y: -30,
          },
          {
            x: -100,
            y: 20,
          },
        ],
      ],
      entrance: {
        x: 0,
        y: -90,
      },
      depthOffset: 0,
    },
    {
      id: 'industry-sugar_processor',
      name: 'Máy Chế Biến Đường',
      kind: 'machine',
      node: 'industry-sugar_processor',
      position: {
        x: 1080,
        y: 470,
      },
      footprints: [
        [
          {
            x: 0,
            y: 70,
          },
          {
            x: 100,
            y: 20,
          },
          {
            x: 0,
            y: -30,
          },
          {
            x: -100,
            y: 20,
          },
        ],
      ],
      entrance: {
        x: 0,
        y: -90,
      },
      depthOffset: 0,
    },
  ],
  obstacles: [
    {
      id: 'R001',
      polygon: [
        {
          x: -13,
          y: 34,
        },
        {
          x: 85,
          y: -20,
        },
        {
          x: -13,
          y: -74,
        },
        {
          x: -111,
          y: -20,
        },
      ],
    },
    {
      id: 'R002',
      polygon: [
        {
          x: 101,
          y: -24,
        },
        {
          x: 199,
          y: -78,
        },
        {
          x: 101,
          y: -132,
        },
        {
          x: 3,
          y: -78,
        },
      ],
    },
    {
      id: 'R003',
      polygon: [
        {
          x: 215,
          y: -82,
        },
        {
          x: 313,
          y: -136,
        },
        {
          x: 215,
          y: -190,
        },
        {
          x: 117,
          y: -136,
        },
      ],
    },
    {
      id: 'R004',
      polygon: [
        {
          x: -121,
          y: -24,
        },
        {
          x: -23,
          y: -78,
        },
        {
          x: -121,
          y: -132,
        },
        {
          x: -219,
          y: -78,
        },
      ],
    },
    {
      id: 'R005',
      polygon: [
        {
          x: -7,
          y: -82,
        },
        {
          x: 91,
          y: -136,
        },
        {
          x: -7,
          y: -190,
        },
        {
          x: -105,
          y: -136,
        },
      ],
    },
    {
      id: 'R006',
      polygon: [
        {
          x: 107,
          y: -140,
        },
        {
          x: 205,
          y: -194,
        },
        {
          x: 107,
          y: -248,
        },
        {
          x: 9,
          y: -194,
        },
      ],
    },
    {
      id: 'R007',
      polygon: [
        {
          x: -229,
          y: -82,
        },
        {
          x: -131,
          y: -136,
        },
        {
          x: -229,
          y: -190,
        },
        {
          x: -327,
          y: -136,
        },
      ],
    },
    {
      id: 'R008',
      polygon: [
        {
          x: -115,
          y: -140,
        },
        {
          x: -17,
          y: -194,
        },
        {
          x: -115,
          y: -248,
        },
        {
          x: -213,
          y: -194,
        },
      ],
    },
    {
      id: 'R009',
      polygon: [
        {
          x: -1,
          y: -198,
        },
        {
          x: 97,
          y: -252,
        },
        {
          x: -1,
          y: -306,
        },
        {
          x: -99,
          y: -252,
        },
      ],
    },
    {
      id: 'R010',
      polygon: [
        {
          x: -337,
          y: -140,
        },
        {
          x: -239,
          y: -194,
        },
        {
          x: -337,
          y: -248,
        },
        {
          x: -435,
          y: -194,
        },
      ],
    },
    {
      id: 'R011',
      polygon: [
        {
          x: -223,
          y: -198,
        },
        {
          x: -125,
          y: -252,
        },
        {
          x: -223,
          y: -306,
        },
        {
          x: -321,
          y: -252,
        },
      ],
    },
    {
      id: 'R012',
      polygon: [
        {
          x: -109,
          y: -256,
        },
        {
          x: -11,
          y: -310,
        },
        {
          x: -109,
          y: -364,
        },
        {
          x: -207,
          y: -310,
        },
      ],
    },
    {
      id: 'R013',
      polygon: [
        {
          x: 329,
          y: -140,
        },
        {
          x: 427,
          y: -194,
        },
        {
          x: 329,
          y: -248,
        },
        {
          x: 231,
          y: -194,
        },
      ],
    },
    {
      id: 'R014',
      polygon: [
        {
          x: 221,
          y: -198,
        },
        {
          x: 319,
          y: -252,
        },
        {
          x: 221,
          y: -306,
        },
        {
          x: 123,
          y: -252,
        },
      ],
    },
    {
      id: 'R015',
      polygon: [
        {
          x: 113,
          y: -256,
        },
        {
          x: 211,
          y: -310,
        },
        {
          x: 113,
          y: -364,
        },
        {
          x: 15,
          y: -310,
        },
      ],
    },
    {
      id: 'R016',
      polygon: [
        {
          x: 5,
          y: -314,
        },
        {
          x: 103,
          y: -368,
        },
        {
          x: 5,
          y: -422,
        },
        {
          x: -93,
          y: -368,
        },
      ],
    },
    {
      id: 'R017',
      polygon: [
        {
          x: 443,
          y: -198,
        },
        {
          x: 541,
          y: -252,
        },
        {
          x: 443,
          y: -306,
        },
        {
          x: 345,
          y: -252,
        },
      ],
    },
    {
      id: 'R018',
      polygon: [
        {
          x: 335,
          y: -256,
        },
        {
          x: 433,
          y: -310,
        },
        {
          x: 335,
          y: -364,
        },
        {
          x: 237,
          y: -310,
        },
      ],
    },
    {
      id: 'R019',
      polygon: [
        {
          x: 227,
          y: -314,
        },
        {
          x: 325,
          y: -368,
        },
        {
          x: 227,
          y: -422,
        },
        {
          x: 129,
          y: -368,
        },
      ],
    },
    {
      id: 'R020',
      polygon: [
        {
          x: 119,
          y: -372,
        },
        {
          x: 217,
          y: -426,
        },
        {
          x: 119,
          y: -480,
        },
        {
          x: 21,
          y: -426,
        },
      ],
    },
    {
      id: 'R021',
      polygon: [
        {
          x: 557,
          y: -256,
        },
        {
          x: 655,
          y: -310,
        },
        {
          x: 557,
          y: -364,
        },
        {
          x: 459,
          y: -310,
        },
      ],
    },
    {
      id: 'R022',
      polygon: [
        {
          x: 449,
          y: -314,
        },
        {
          x: 547,
          y: -368,
        },
        {
          x: 449,
          y: -422,
        },
        {
          x: 351,
          y: -368,
        },
      ],
    },
    {
      id: 'R023',
      polygon: [
        {
          x: 341,
          y: -372,
        },
        {
          x: 439,
          y: -426,
        },
        {
          x: 341,
          y: -480,
        },
        {
          x: 243,
          y: -426,
        },
      ],
    },
    {
      id: 'R024',
      polygon: [
        {
          x: 233,
          y: -430,
        },
        {
          x: 331,
          y: -484,
        },
        {
          x: 233,
          y: -538,
        },
        {
          x: 135,
          y: -484,
        },
      ],
    },
    {
      id: 'R025',
      polygon: [
        {
          x: 671,
          y: -314,
        },
        {
          x: 769,
          y: -368,
        },
        {
          x: 671,
          y: -422,
        },
        {
          x: 573,
          y: -368,
        },
      ],
    },
    {
      id: 'R026',
      polygon: [
        {
          x: 563,
          y: -372,
        },
        {
          x: 661,
          y: -426,
        },
        {
          x: 563,
          y: -480,
        },
        {
          x: 465,
          y: -426,
        },
      ],
    },
    {
      id: 'R027',
      polygon: [
        {
          x: 455,
          y: -430,
        },
        {
          x: 553,
          y: -484,
        },
        {
          x: 455,
          y: -538,
        },
        {
          x: 357,
          y: -484,
        },
      ],
    },
    {
      id: 'R028',
      polygon: [
        {
          x: 347,
          y: -488,
        },
        {
          x: 445,
          y: -542,
        },
        {
          x: 347,
          y: -596,
        },
        {
          x: 249,
          y: -542,
        },
      ],
    },
    {
      id: 'R029',
      polygon: [
        {
          x: 785,
          y: -372,
        },
        {
          x: 883,
          y: -426,
        },
        {
          x: 785,
          y: -480,
        },
        {
          x: 687,
          y: -426,
        },
      ],
    },
    {
      id: 'R030',
      polygon: [
        {
          x: 677,
          y: -430,
        },
        {
          x: 775,
          y: -484,
        },
        {
          x: 677,
          y: -538,
        },
        {
          x: 579,
          y: -484,
        },
      ],
    },
    {
      id: 'R031',
      polygon: [
        {
          x: 569,
          y: -488,
        },
        {
          x: 667,
          y: -542,
        },
        {
          x: 569,
          y: -596,
        },
        {
          x: 471,
          y: -542,
        },
      ],
    },
    {
      id: 'R032',
      polygon: [
        {
          x: 461,
          y: -546,
        },
        {
          x: 559,
          y: -600,
        },
        {
          x: 461,
          y: -654,
        },
        {
          x: 363,
          y: -600,
        },
      ],
    },
    {
      id: 'R033',
      polygon: [
        {
          x: -445,
          y: -198,
        },
        {
          x: -347,
          y: -252,
        },
        {
          x: -445,
          y: -306,
        },
        {
          x: -543,
          y: -252,
        },
      ],
    },
    {
      id: 'R034',
      polygon: [
        {
          x: -331,
          y: -256,
        },
        {
          x: -233,
          y: -310,
        },
        {
          x: -331,
          y: -364,
        },
        {
          x: -429,
          y: -310,
        },
      ],
    },
    {
      id: 'R035',
      polygon: [
        {
          x: -217,
          y: -314,
        },
        {
          x: -119,
          y: -368,
        },
        {
          x: -217,
          y: -422,
        },
        {
          x: -315,
          y: -368,
        },
      ],
    },
    {
      id: 'R036',
      polygon: [
        {
          x: -103,
          y: -372,
        },
        {
          x: -5,
          y: -426,
        },
        {
          x: -103,
          y: -480,
        },
        {
          x: -201,
          y: -426,
        },
      ],
    },
    {
      id: 'R037',
      polygon: [
        {
          x: 11,
          y: -430,
        },
        {
          x: 109,
          y: -484,
        },
        {
          x: 11,
          y: -538,
        },
        {
          x: -87,
          y: -484,
        },
      ],
    },
    {
      id: 'R038',
      polygon: [
        {
          x: 125,
          y: -488,
        },
        {
          x: 223,
          y: -542,
        },
        {
          x: 125,
          y: -596,
        },
        {
          x: 27,
          y: -542,
        },
      ],
    },
    {
      id: 'R039',
      polygon: [
        {
          x: 239,
          y: -546,
        },
        {
          x: 337,
          y: -600,
        },
        {
          x: 239,
          y: -654,
        },
        {
          x: 141,
          y: -600,
        },
      ],
    },
    {
      id: 'R040',
      polygon: [
        {
          x: 353,
          y: -604,
        },
        {
          x: 451,
          y: -658,
        },
        {
          x: 353,
          y: -712,
        },
        {
          x: 255,
          y: -658,
        },
      ],
    },
    {
      id: 'MainObject-ao ca',
      polygon: [
        {
          x: -445,
          y: 210,
        },
        {
          x: -195,
          y: 65,
        },
        {
          x: -445,
          y: -80,
        },
        {
          x: -695,
          y: 65,
        },
      ],
    },
    {
      id: 'MainObject-gieng',
      polygon: [
        {
          x: -580,
          y: -267.5,
        },
        {
          x: -475,
          y: -315,
        },
        {
          x: -580,
          y: -362.5,
        },
        {
          x: -685,
          y: -315,
        },
      ],
    },
    {
      id: 'MainObject-xay gio',
      polygon: [
        {
          x: 811,
          y: 339,
        },
        {
          x: 913.5,
          y: 294,
        },
        {
          x: 811,
          y: 249,
        },
        {
          x: 708.5,
          y: 294,
        },
      ],
    },
    {
      id: 'MainObject-chuong cho',
      polygon: [
        {
          x: -412,
          y: -442,
        },
        {
          x: -344.5,
          y: -477,
        },
        {
          x: -412,
          y: -512,
        },
        {
          x: -479.5,
          y: -477,
        },
      ],
    },
  ],
  decor: [
    {
      id: 'barn-cart',
      polygon: [
        {
          x: -225,
          y: 387.5,
        },
        {
          x: -170,
          y: 365,
        },
        {
          x: -225,
          y: 342.5,
        },
        {
          x: -280,
          y: 365,
        },
      ],
    },
    {
      id: 'field-sign',
      polygon: [
        {
          x: -265,
          y: 39,
        },
        {
          x: -245,
          y: 30,
        },
        {
          x: -265,
          y: 21,
        },
        {
          x: -285,
          y: 30,
        },
      ],
    },
    {
      id: 'field-scarecrow',
      polygon: [
        {
          x: -265,
          y: -521,
        },
        {
          x: -245,
          y: -530,
        },
        {
          x: -265,
          y: -539,
        },
        {
          x: -285,
          y: -530,
        },
      ],
    },
    {
      id: 'pen-hay',
      polygon: [
        {
          x: 10,
          y: 244,
        },
        {
          x: 30,
          y: 235,
        },
        {
          x: 10,
          y: 226,
        },
        {
          x: -10,
          y: 235,
        },
      ],
    },
    {
      id: 'pen-fence-a',
      polygon: [
        {
          x: 90,
          y: 304,
        },
        {
          x: 132.5,
          y: 285,
        },
        {
          x: 90,
          y: 266,
        },
        {
          x: 47.5,
          y: 285,
        },
      ],
    },
    {
      id: 'pen-fence-b',
      polygon: [
        {
          x: 165,
          y: 343,
        },
        {
          x: 207.5,
          y: 324,
        },
        {
          x: 165,
          y: 305,
        },
        {
          x: 122.5,
          y: 324,
        },
      ],
    },
    {
      id: 'pen-fence-c',
      polygon: [
        {
          x: 444,
          y: 209,
        },
        {
          x: 486.5,
          y: 190,
        },
        {
          x: 444,
          y: 171,
        },
        {
          x: 401.5,
          y: 190,
        },
      ],
    },
    {
      id: 'pen-fence-d',
      polygon: [
        {
          x: 510,
          y: 174,
        },
        {
          x: 552.5,
          y: 155,
        },
        {
          x: 510,
          y: 136,
        },
        {
          x: 467.5,
          y: 155,
        },
      ],
    },
    {
      id: 'house-daisies',
      polygon: [
        {
          x: -535,
          y: 254,
        },
        {
          x: -515,
          y: 245,
        },
        {
          x: -535,
          y: 236,
        },
        {
          x: -555,
          y: 245,
        },
      ],
    },
    {
      id: 'barn-poppies',
      polygon: [
        {
          x: 25,
          y: 414,
        },
        {
          x: 45,
          y: 405,
        },
        {
          x: 25,
          y: 396,
        },
        {
          x: 5,
          y: 405,
        },
      ],
    },
    {
      id: 'well-stone',
      polygon: [
        {
          x: -688,
          y: -209,
        },
        {
          x: -668,
          y: -218,
        },
        {
          x: -688,
          y: -227,
        },
        {
          x: -708,
          y: -218,
        },
      ],
    },
    {
      id: 'well-pebbles',
      polygon: [
        {
          x: -651,
          y: -301,
        },
        {
          x: -631,
          y: -310,
        },
        {
          x: -651,
          y: -319,
        },
        {
          x: -671,
          y: -310,
        },
      ],
    },
    {
      id: 'pond-rock',
      polygon: [
        {
          x: -696,
          y: 37,
        },
        {
          x: -676,
          y: 28,
        },
        {
          x: -696,
          y: 19,
        },
        {
          x: -716,
          y: 28,
        },
      ],
    },
    {
      id: 'pond-stump',
      polygon: [
        {
          x: -703,
          y: 200,
        },
        {
          x: -683,
          y: 191,
        },
        {
          x: -703,
          y: 182,
        },
        {
          x: -723,
          y: 191,
        },
      ],
    },
    {
      id: 'bakery-flowers',
      polygon: [
        {
          x: 556,
          y: 173,
        },
        {
          x: 576,
          y: 164,
        },
        {
          x: 556,
          y: 155,
        },
        {
          x: 536,
          y: 164,
        },
      ],
    },
    {
      id: 'dairy-bush',
      polygon: [
        {
          x: 1025,
          y: -56,
        },
        {
          x: 1045,
          y: -65,
        },
        {
          x: 1025,
          y: -74,
        },
        {
          x: 1005,
          y: -65,
        },
      ],
    },
    {
      id: 'feed-bush',
      polygon: [
        {
          x: 1182,
          y: -291,
        },
        {
          x: 1202,
          y: -300,
        },
        {
          x: 1182,
          y: -309,
        },
        {
          x: 1162,
          y: -300,
        },
      ],
    },
    {
      id: 'grill-flowers',
      polygon: [
        {
          x: 1178,
          y: 164,
        },
        {
          x: 1198,
          y: 155,
        },
        {
          x: 1178,
          y: 146,
        },
        {
          x: 1158,
          y: 155,
        },
      ],
    },
    {
      id: 'sugar-bush',
      polygon: [
        {
          x: 1220,
          y: 483,
        },
        {
          x: 1240,
          y: 474,
        },
        {
          x: 1220,
          y: 465,
        },
        {
          x: 1200,
          y: 474,
        },
      ],
    },
    {
      id: 'popcorn-flowers',
      polygon: [
        {
          x: 1176,
          y: -561,
        },
        {
          x: 1196,
          y: -570,
        },
        {
          x: 1176,
          y: -579,
        },
        {
          x: 1156,
          y: -570,
        },
      ],
    },
    {
      id: 'pie-bush',
      polygon: [
        {
          x: 937,
          y: -838,
        },
        {
          x: 957,
          y: -847,
        },
        {
          x: 937,
          y: -856,
        },
        {
          x: 917,
          y: -847,
        },
      ],
    },
  ],
  fieldEntrance: {
    x: -200,
    y: 20,
  },
};
