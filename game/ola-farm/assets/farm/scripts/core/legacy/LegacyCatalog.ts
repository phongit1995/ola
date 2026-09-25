import type { FarmCatalog } from '../types/CatalogTypes';

/** Frozen pre-integration values: only used to validate and migrate state v2. */
export const legacyCatalog: FarmCatalog = {
  farm: [
    {
      id: 1,
      name: 'Lúa mì',
      key: 'wheat',
      price: 20,
      duration: 102,
      yields: [3, 5, 7, 9],
      group: 'crop',
      image: '1.wheat',
    },
    {
      id: 2,
      name: 'Cà chua',
      key: 'tomato',
      price: 25,
      duration: 102,
      yields: [3, 5, 7, 9],
      group: 'crop',
      image: '2.tomato',
    },
    {
      id: 3,
      name: 'Nho',
      key: 'grapes',
      price: 26,
      duration: 102,
      yields: [3, 5, 7, 9],
      group: 'crop',
      image: '3.grapes',
    },
    {
      id: 4,
      name: 'Dâu tây',
      key: 'strawberry',
      price: 27,
      duration: 102,
      yields: [3, 5, 7, 9],
      group: 'crop',
      image: '4.strawberry',
    },
    {
      id: 5,
      name: 'Gà',
      key: 'chicken',
      price: 31,
      duration: 108,
      yields: [3, 5, 7, 9],
      group: 'pen',
      image: '5.chicken_1',
    },
    {
      id: 6,
      name: 'Heo',
      key: 'pig',
      price: 29,
      duration: 108,
      yields: [3, 5, 7, 9],
      group: 'pen',
      image: '6.pig',
    },
    {
      id: 7,
      name: 'Bò sữa',
      key: 'cow',
      price: 30,
      duration: 108,
      yields: [3, 5, 7, 9],
      group: 'pen',
      image: '7.cow',
    },
    {
      id: 8,
      name: 'Cá',
      key: 'fish',
      price: 29,
      duration: 108,
      yields: [3, 5, 7, 9],
      group: 'pond',
      image: '8.fish',
    },
    {
      id: 9,
      name: 'Tôm',
      key: 'shrimp',
      price: 30,
      duration: 108,
      yields: [3, 5, 7, 9],
      group: 'pond',
      image: '9.shrimp',
    },
  ],
  products: [
    {
      id: 7,
      name: 'Bánh mì',
      image: 'banhmi',
      duration: 19,
      price: 85,
      machine: 1,
      ingredients: [
        {
          id: 1,
          quantity: 2,
        },
      ],
    },
    {
      id: 8,
      name: 'Bánh quy',
      image: 'cookie',
      duration: 20,
      price: 90,
      machine: 1,
      ingredients: [
        {
          id: 1,
          quantity: 2,
        },
        {
          id: 7,
          quantity: 1,
        },
      ],
    },
    {
      id: 9,
      name: 'Bánh nho',
      image: 'banhnho',
      duration: 20,
      price: 95,
      machine: 1,
      ingredients: [
        {
          id: 1,
          quantity: 2,
        },
        {
          id: 3,
          quantity: 1,
        },
      ],
    },
    {
      id: 10,
      name: 'Bánh dâu',
      image: 'banhdau',
      duration: 20,
      price: 96,
      machine: 1,
      ingredients: [
        {
          id: 1,
          quantity: 2,
        },
        {
          id: 4,
          quantity: 1,
        },
      ],
    },
    {
      id: 11,
      name: 'Bánh tôm',
      image: 'dia-tomran',
      duration: 21,
      price: 92,
      machine: 2,
      ingredients: [
        {
          id: 1,
          quantity: 2,
        },
        {
          id: 9,
          quantity: 1,
        },
      ],
    },
    {
      id: 12,
      name: 'Cá nướng',
      image: 'dia-canuong',
      duration: 20,
      price: 80,
      machine: 2,
      ingredients: [
        {
          id: 8,
          quantity: 1,
        },
      ],
    },
    {
      id: 13,
      name: 'Gà quay',
      image: 'dia-garan',
      duration: 20,
      price: 85,
      machine: 2,
      ingredients: [
        {
          id: 5,
          quantity: 1,
        },
      ],
    },
    {
      id: 14,
      name: 'Hamburger',
      image: 'dia-burger',
      duration: 21,
      price: 99,
      machine: 2,
      ingredients: [
        {
          id: 1,
          quantity: 2,
        },
        {
          id: 6,
          quantity: 1,
        },
      ],
    },
    {
      id: 15,
      name: 'Cà chua sạch',
      image: 'cachua',
      duration: 19,
      price: 80,
      machine: 3,
      ingredients: [
        {
          id: 2,
          quantity: 1,
        },
      ],
    },
    {
      id: 16,
      name: 'Nho tươi',
      image: 'nho',
      duration: 19,
      price: 85,
      machine: 3,
      ingredients: [
        {
          id: 3,
          quantity: 1,
        },
      ],
    },
    {
      id: 17,
      name: 'Dâu tươi',
      image: 'dau',
      duration: 19,
      price: 82,
      machine: 3,
      ingredients: [
        {
          id: 4,
          quantity: 1,
        },
      ],
    },
    {
      id: 18,
      name: 'Sữa dâu',
      image: 'suadau',
      duration: 20,
      price: 88,
      machine: 4,
      ingredients: [
        {
          id: 7,
          quantity: 1,
        },
        {
          id: 4,
          quantity: 1,
        },
      ],
    },
    {
      id: 19,
      name: 'Sữa tươi',
      image: 'suabo',
      duration: 19,
      price: 80,
      machine: 4,
      ingredients: [
        {
          id: 7,
          quantity: 1,
        },
      ],
    },
    {
      id: 20,
      name: 'Bơ',
      image: 'bo',
      duration: 20,
      price: 86,
      machine: 4,
      ingredients: [
        {
          id: 7,
          quantity: 2,
        },
      ],
    },
    {
      id: 21,
      name: 'Sữa nho',
      image: 'suanho',
      duration: 21,
      price: 84,
      machine: 4,
      ingredients: [
        {
          id: 7,
          quantity: 1,
        },
        {
          id: 3,
          quantity: 1,
        },
      ],
    },
    {
      id: 22,
      name: 'Phô mai',
      image: 'cheese',
      duration: 20,
      price: 90,
      machine: 4,
      ingredients: [
        {
          id: 7,
          quantity: 2,
        },
      ],
    },
  ],
};
