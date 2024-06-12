import plugin from "tailwindcss/plugin";

/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  darkMode: "class",
  theme: {
    extend: {
      colors: {
        "111B3B": "#111B3B",
        F156A1: "#F156A1",
        fef1f7: "#fef1f7",
        "3AD78E": "#3AD78E",
        111111: "#111111",
        FF5151: "#FF5151",
      },
      backgroundImage: () => ({
        "gradient-pink":
          "linear-gradient(to top right, #F156A1 3.16%, #F794C4 96.84%)",
      }),
      fontFamily: {},
      fontSize: { 9: "9px", 11: "11px", 13: "13px" },
    },
  },
  plugins: [
    plugin(function ({ addUtilities }) {
      const newUtilities = {
        ".scrollbar-hide::-webkit-scrollbar": { display: "none" },
        ".scrollbar-hide": {
          "scrollbar-width": "none",
          "-ms-overflow-style": "none",
        },
      };
      addUtilities(newUtilities);
    }),
  ],
};
