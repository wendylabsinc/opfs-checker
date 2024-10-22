import { defineConfig } from "vite";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [],
  base: process.env.GITHUB_ACTIONS ? "/opfs-checker/" : "/",
});
