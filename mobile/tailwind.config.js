/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./App.tsx', './src/**/*.{ts,tsx}'],
  presets: [require('nativewind/preset')],
  theme: {
    extend: {
      colors: {
        'ola-primary': '#7cb342',
        'ola-primary-dark': '#558b2f',
        'ola-primary-darker': '#33691e',
        'ola-primary-light': '#f1f8e9',
        'ola-button': '#9ccc65',
        'ola-accent': '#ff4081',
        'ola-accent-dark': '#f50057',
        'ola-error': '#e34545',
        'ola-warning': '#ff9800',
      },
    },
  },
  plugins: [],
};
