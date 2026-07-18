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
        'ola-ink': 'rgba(0,0,0,0.87)',
        'ola-ink-soft': 'rgba(0,0,0,0.54)',
        'ola-ink-faint': 'rgba(0,0,0,0.38)',
        'ola-ink-hint': 'rgba(0,0,0,0.26)',
        'ola-divider': 'rgba(0,0,0,0.12)',
        'ola-warning': '#ff9800',
      },
    },
  },
  plugins: [],
};
