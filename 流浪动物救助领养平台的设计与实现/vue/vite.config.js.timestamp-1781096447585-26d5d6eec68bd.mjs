// vite.config.js
import { defineConfig, loadEnv } from "file:///D:/work/animal-succour/vue/node_modules/vite/dist/node/index.js";
import path2 from "path";

// vite/plugins/index.js
import vue from "file:///D:/work/animal-succour/vue/node_modules/@vitejs/plugin-vue/dist/index.mjs";

// vite/plugins/auto-import.js
import autoImport from "file:///D:/work/animal-succour/vue/node_modules/unplugin-auto-import/dist/vite.js";
function createAutoImport() {
  return autoImport({
    imports: [
      "vue",
      "vue-router",
      "pinia"
    ],
    dts: false
  });
}

// vite/plugins/svg-icon.js
import { createSvgIconsPlugin } from "file:///D:/work/animal-succour/vue/node_modules/vite-plugin-svg-icons/dist/index.mjs";
import path from "path";
function createSvgIcon(isBuild) {
  return createSvgIconsPlugin({
    iconDirs: [path.resolve(process.cwd(), "src/assets/icons/svg")],
    symbolId: "icon-[dir]-[name]",
    svgoOptions: isBuild
  });
}

// vite/plugins/compression.js
import compression from "file:///D:/work/animal-succour/vue/node_modules/vite-plugin-compression/dist/index.mjs";
function createCompression(env) {
  const { VITE_BUILD_COMPRESS } = env;
  const plugin = [];
  if (VITE_BUILD_COMPRESS) {
    const compressList = VITE_BUILD_COMPRESS.split(",");
    if (compressList.includes("gzip")) {
      plugin.push(
        compression({
          ext: ".gz",
          deleteOriginFile: false
        })
      );
    }
    if (compressList.includes("brotli")) {
      plugin.push(
        compression({
          ext: ".br",
          algorithm: "brotliCompress",
          deleteOriginFile: false
        })
      );
    }
  }
  return plugin;
}

// vite/plugins/index.js
function createVitePlugins(viteEnv, isBuild = false) {
  const vitePlugins = [vue()];
  vitePlugins.push(createAutoImport());
  vitePlugins.push(createSvgIcon(isBuild));
  isBuild && vitePlugins.push(...createCompression(viteEnv));
  return vitePlugins;
}

// vite.config.js
var __vite_injected_original_dirname = "D:\\work\\animal-succour\\vue";
var baseUrl = "http://localhost:8080";
var vite_config_default = defineConfig(({ mode, command }) => {
  const env = loadEnv(mode, process.cwd());
  const { VITE_APP_ENV } = env;
  return {
    // 部署生产环境和开发环境下的URL。
    base: VITE_APP_ENV === "production" ? "/" : "/",
    plugins: createVitePlugins(env, command === "build"),
    resolve: {
      // https://cn.vitejs.dev/config/#resolve-alias
      alias: {
        // 设置路径
        "~": path2.resolve(__vite_injected_original_dirname, "./"),
        // 设置别名
        "@": path2.resolve(__vite_injected_original_dirname, "./src")
      },
      // https://cn.vitejs.dev/config/#resolve-extensions
      extensions: [".mjs", ".js", ".ts", ".jsx", ".tsx", ".json", ".vue"]
    },
    // 打包配置
    build: {
      // https://vite.dev/config/build-options.html
      sourcemap: command === "build" ? false : "inline",
      outDir: "dist",
      assetsDir: "assets",
      chunkSizeWarningLimit: 2e3,
      rollupOptions: {
        output: {
          chunkFileNames: "static/js/[name]-[hash].js",
          entryFileNames: "static/js/[name]-[hash].js",
          assetFileNames: "static/[ext]/[name]-[hash].[ext]"
        }
      }
    },
    // vite 相关配置
    server: {
      port: 90,
      host: true,
      open: true,
      proxy: {
        // https://cn.vitejs.dev/config/#server-proxy
        "/dev-api": {
          target: baseUrl,
          changeOrigin: true,
          rewrite: (p) => p.replace(/^\/dev-api/, "")
        },
        // springdoc proxy
        "^/v3/api-docs/(.*)": {
          target: baseUrl,
          changeOrigin: true
        }
      }
    },
    css: {
      postcss: {
        plugins: [
          {
            postcssPlugin: "internal:charset-removal",
            AtRule: {
              charset: (atRule) => {
                if (atRule.name === "charset") {
                  atRule.remove();
                }
              }
            }
          }
        ]
      }
    }
  };
});
export {
  vite_config_default as default
};
//# sourceMappingURL=data:application/json;base64,ewogICJ2ZXJzaW9uIjogMywKICAic291cmNlcyI6IFsidml0ZS5jb25maWcuanMiLCAidml0ZS9wbHVnaW5zL2luZGV4LmpzIiwgInZpdGUvcGx1Z2lucy9hdXRvLWltcG9ydC5qcyIsICJ2aXRlL3BsdWdpbnMvc3ZnLWljb24uanMiLCAidml0ZS9wbHVnaW5zL2NvbXByZXNzaW9uLmpzIl0sCiAgInNvdXJjZXNDb250ZW50IjogWyJjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfZGlybmFtZSA9IFwiRDpcXFxcd29ya1xcXFxhbmltYWwtc3VjY291clxcXFx2dWVcIjtjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfZmlsZW5hbWUgPSBcIkQ6XFxcXHdvcmtcXFxcYW5pbWFsLXN1Y2NvdXJcXFxcdnVlXFxcXHZpdGUuY29uZmlnLmpzXCI7Y29uc3QgX192aXRlX2luamVjdGVkX29yaWdpbmFsX2ltcG9ydF9tZXRhX3VybCA9IFwiZmlsZTovLy9EOi93b3JrL2FuaW1hbC1zdWNjb3VyL3Z1ZS92aXRlLmNvbmZpZy5qc1wiO2ltcG9ydCB7IGRlZmluZUNvbmZpZywgbG9hZEVudiB9IGZyb20gJ3ZpdGUnXHJcbmltcG9ydCBwYXRoIGZyb20gJ3BhdGgnXHJcbmltcG9ydCBjcmVhdGVWaXRlUGx1Z2lucyBmcm9tICcuL3ZpdGUvcGx1Z2lucydcclxuXHJcbmNvbnN0IGJhc2VVcmwgPSAnaHR0cDovL2xvY2FsaG9zdDo4MDgwJyAvLyBcdTU0MEVcdTdBRUZcdTYzQTVcdTUzRTNcclxuXHJcbi8vIGh0dHBzOi8vdml0ZWpzLmRldi9jb25maWcvXHJcbmV4cG9ydCBkZWZhdWx0IGRlZmluZUNvbmZpZygoeyBtb2RlLCBjb21tYW5kIH0pID0+IHtcclxuICBjb25zdCBlbnYgPSBsb2FkRW52KG1vZGUsIHByb2Nlc3MuY3dkKCkpXHJcbiAgY29uc3QgeyBWSVRFX0FQUF9FTlYgfSA9IGVudlxyXG4gIHJldHVybiB7XHJcbiAgICAvLyBcdTkwRThcdTdGNzJcdTc1MUZcdTRFQTdcdTczQUZcdTU4ODNcdTU0OENcdTVGMDBcdTUzRDFcdTczQUZcdTU4ODNcdTRFMEJcdTc2ODRVUkxcdTMwMDJcclxuICAgIC8vIFx1OUVEOFx1OEJBNFx1NjBDNVx1NTFCNVx1NEUwQlx1RkYwQ3ZpdGUgXHU0RjFBXHU1MDQ3XHU4QkJFXHU0RjYwXHU3Njg0XHU1RTk0XHU3NTI4XHU2NjJGXHU4OEFCXHU5MEU4XHU3RjcyXHU1NzI4XHU0RTAwXHU0RTJBXHU1N0RGXHU1NDBEXHU3Njg0XHU2ODM5XHU4REVGXHU1Rjg0XHU0RTBBXHJcbiAgICAvLyBcdTRGOEJcdTU5ODIgaHR0cHM6Ly93d3cuaHVhY2FpLnZpcC9cdTMwMDJcdTU5ODJcdTY3OUNcdTVFOTRcdTc1MjhcdTg4QUJcdTkwRThcdTdGNzJcdTU3MjhcdTRFMDBcdTRFMkFcdTVCNTBcdThERUZcdTVGODRcdTRFMEFcdUZGMENcdTRGNjBcdTVDMzFcdTk3MDBcdTg5ODFcdTc1MjhcdThGRDlcdTRFMkFcdTkwMDlcdTk4NzlcdTYzMDdcdTVCOUFcdThGRDlcdTRFMkFcdTVCNTBcdThERUZcdTVGODRcdTMwMDJcdTRGOEJcdTU5ODJcdUZGMENcdTU5ODJcdTY3OUNcdTRGNjBcdTc2ODRcdTVFOTRcdTc1MjhcdTg4QUJcdTkwRThcdTdGNzJcdTU3MjggaHR0cHM6Ly93d3cuaHVhY2FpLnZpcC9hZG1pbi9cdUZGMENcdTUyMTlcdThCQkVcdTdGNkUgYmFzZVVybCBcdTRFM0EgL2FkbWluL1x1MzAwMlxyXG4gICAgYmFzZTogVklURV9BUFBfRU5WID09PSAncHJvZHVjdGlvbicgPyAnLycgOiAnLycsXHJcbiAgICBwbHVnaW5zOiBjcmVhdGVWaXRlUGx1Z2lucyhlbnYsIGNvbW1hbmQgPT09ICdidWlsZCcpLFxyXG4gICAgcmVzb2x2ZToge1xyXG4gICAgICAvLyBodHRwczovL2NuLnZpdGVqcy5kZXYvY29uZmlnLyNyZXNvbHZlLWFsaWFzXHJcbiAgICAgIGFsaWFzOiB7XHJcbiAgICAgICAgLy8gXHU4QkJFXHU3RjZFXHU4REVGXHU1Rjg0XHJcbiAgICAgICAgJ34nOiBwYXRoLnJlc29sdmUoX19kaXJuYW1lLCAnLi8nKSxcclxuICAgICAgICAvLyBcdThCQkVcdTdGNkVcdTUyMkJcdTU0MERcclxuICAgICAgICAnQCc6IHBhdGgucmVzb2x2ZShfX2Rpcm5hbWUsICcuL3NyYycpXHJcbiAgICAgIH0sXHJcbiAgICAgIC8vIGh0dHBzOi8vY24udml0ZWpzLmRldi9jb25maWcvI3Jlc29sdmUtZXh0ZW5zaW9uc1xyXG4gICAgICBleHRlbnNpb25zOiBbJy5tanMnLCAnLmpzJywgJy50cycsICcuanN4JywgJy50c3gnLCAnLmpzb24nLCAnLnZ1ZSddXHJcbiAgICB9LFxyXG4gICAgLy8gXHU2MjUzXHU1MzA1XHU5MTREXHU3RjZFXHJcbiAgICBidWlsZDoge1xyXG4gICAgICAvLyBodHRwczovL3ZpdGUuZGV2L2NvbmZpZy9idWlsZC1vcHRpb25zLmh0bWxcclxuICAgICAgc291cmNlbWFwOiBjb21tYW5kID09PSAnYnVpbGQnID8gZmFsc2UgOiAnaW5saW5lJyxcclxuICAgICAgb3V0RGlyOiAnZGlzdCcsXHJcbiAgICAgIGFzc2V0c0RpcjogJ2Fzc2V0cycsXHJcbiAgICAgIGNodW5rU2l6ZVdhcm5pbmdMaW1pdDogMjAwMCxcclxuICAgICAgcm9sbHVwT3B0aW9uczoge1xyXG4gICAgICAgIG91dHB1dDoge1xyXG4gICAgICAgICAgY2h1bmtGaWxlTmFtZXM6ICdzdGF0aWMvanMvW25hbWVdLVtoYXNoXS5qcycsXHJcbiAgICAgICAgICBlbnRyeUZpbGVOYW1lczogJ3N0YXRpYy9qcy9bbmFtZV0tW2hhc2hdLmpzJyxcclxuICAgICAgICAgIGFzc2V0RmlsZU5hbWVzOiAnc3RhdGljL1tleHRdL1tuYW1lXS1baGFzaF0uW2V4dF0nXHJcbiAgICAgICAgfVxyXG4gICAgICB9XHJcbiAgICB9LFxyXG4gICAgLy8gdml0ZSBcdTc2RjhcdTUxNzNcdTkxNERcdTdGNkVcclxuICAgIHNlcnZlcjoge1xyXG4gICAgICBwb3J0OiA5MCxcclxuICAgICAgaG9zdDogdHJ1ZSxcclxuICAgICAgb3BlbjogdHJ1ZSxcclxuICAgICAgcHJveHk6IHtcclxuICAgICAgICAvLyBodHRwczovL2NuLnZpdGVqcy5kZXYvY29uZmlnLyNzZXJ2ZXItcHJveHlcclxuICAgICAgICAnL2Rldi1hcGknOiB7XHJcbiAgICAgICAgICB0YXJnZXQ6IGJhc2VVcmwsXHJcbiAgICAgICAgICBjaGFuZ2VPcmlnaW46IHRydWUsXHJcbiAgICAgICAgICByZXdyaXRlOiAocCkgPT4gcC5yZXBsYWNlKC9eXFwvZGV2LWFwaS8sICcnKVxyXG4gICAgICAgIH0sXHJcbiAgICAgICAgIC8vIHNwcmluZ2RvYyBwcm94eVxyXG4gICAgICAgICAnXi92My9hcGktZG9jcy8oLiopJzoge1xyXG4gICAgICAgICAgdGFyZ2V0OiBiYXNlVXJsLFxyXG4gICAgICAgICAgY2hhbmdlT3JpZ2luOiB0cnVlLFxyXG4gICAgICAgIH1cclxuICAgICAgfVxyXG4gICAgfSxcclxuICAgIGNzczoge1xyXG4gICAgICBwb3N0Y3NzOiB7XHJcbiAgICAgICAgcGx1Z2luczogW1xyXG4gICAgICAgICAge1xyXG4gICAgICAgICAgICBwb3N0Y3NzUGx1Z2luOiAnaW50ZXJuYWw6Y2hhcnNldC1yZW1vdmFsJyxcclxuICAgICAgICAgICAgQXRSdWxlOiB7XHJcbiAgICAgICAgICAgICAgY2hhcnNldDogKGF0UnVsZSkgPT4ge1xyXG4gICAgICAgICAgICAgICAgaWYgKGF0UnVsZS5uYW1lID09PSAnY2hhcnNldCcpIHtcclxuICAgICAgICAgICAgICAgICAgYXRSdWxlLnJlbW92ZSgpXHJcbiAgICAgICAgICAgICAgICB9XHJcbiAgICAgICAgICAgICAgfVxyXG4gICAgICAgICAgICB9XHJcbiAgICAgICAgICB9XHJcbiAgICAgICAgXVxyXG4gICAgICB9XHJcbiAgICB9XHJcbiAgfVxyXG59KVxyXG4iLCAiY29uc3QgX192aXRlX2luamVjdGVkX29yaWdpbmFsX2Rpcm5hbWUgPSBcIkQ6XFxcXHdvcmtcXFxcYW5pbWFsLXN1Y2NvdXJcXFxcdnVlXFxcXHZpdGVcXFxccGx1Z2luc1wiO2NvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9maWxlbmFtZSA9IFwiRDpcXFxcd29ya1xcXFxhbmltYWwtc3VjY291clxcXFx2dWVcXFxcdml0ZVxcXFxwbHVnaW5zXFxcXGluZGV4LmpzXCI7Y29uc3QgX192aXRlX2luamVjdGVkX29yaWdpbmFsX2ltcG9ydF9tZXRhX3VybCA9IFwiZmlsZTovLy9EOi93b3JrL2FuaW1hbC1zdWNjb3VyL3Z1ZS92aXRlL3BsdWdpbnMvaW5kZXguanNcIjtpbXBvcnQgdnVlIGZyb20gJ0B2aXRlanMvcGx1Z2luLXZ1ZSdcclxuXHJcbmltcG9ydCBjcmVhdGVBdXRvSW1wb3J0IGZyb20gJy4vYXV0by1pbXBvcnQnXHJcbmltcG9ydCBjcmVhdGVTdmdJY29uIGZyb20gJy4vc3ZnLWljb24nXHJcbmltcG9ydCBjcmVhdGVDb21wcmVzc2lvbiBmcm9tICcuL2NvbXByZXNzaW9uJ1xyXG5cclxuZXhwb3J0IGRlZmF1bHQgZnVuY3Rpb24gY3JlYXRlVml0ZVBsdWdpbnModml0ZUVudiwgaXNCdWlsZCA9IGZhbHNlKSB7XHJcbiAgICBjb25zdCB2aXRlUGx1Z2lucyA9IFt2dWUoKV1cclxuICAgIHZpdGVQbHVnaW5zLnB1c2goY3JlYXRlQXV0b0ltcG9ydCgpKVxyXG4gICAgdml0ZVBsdWdpbnMucHVzaChjcmVhdGVTdmdJY29uKGlzQnVpbGQpKVxyXG5cdGlzQnVpbGQgJiYgdml0ZVBsdWdpbnMucHVzaCguLi5jcmVhdGVDb21wcmVzc2lvbih2aXRlRW52KSlcclxuICAgIHJldHVybiB2aXRlUGx1Z2luc1xyXG59XHJcbiIsICJjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfZGlybmFtZSA9IFwiRDpcXFxcd29ya1xcXFxhbmltYWwtc3VjY291clxcXFx2dWVcXFxcdml0ZVxcXFxwbHVnaW5zXCI7Y29uc3QgX192aXRlX2luamVjdGVkX29yaWdpbmFsX2ZpbGVuYW1lID0gXCJEOlxcXFx3b3JrXFxcXGFuaW1hbC1zdWNjb3VyXFxcXHZ1ZVxcXFx2aXRlXFxcXHBsdWdpbnNcXFxcYXV0by1pbXBvcnQuanNcIjtjb25zdCBfX3ZpdGVfaW5qZWN0ZWRfb3JpZ2luYWxfaW1wb3J0X21ldGFfdXJsID0gXCJmaWxlOi8vL0Q6L3dvcmsvYW5pbWFsLXN1Y2NvdXIvdnVlL3ZpdGUvcGx1Z2lucy9hdXRvLWltcG9ydC5qc1wiO2ltcG9ydCBhdXRvSW1wb3J0IGZyb20gJ3VucGx1Z2luLWF1dG8taW1wb3J0L3ZpdGUnXHJcblxyXG5leHBvcnQgZGVmYXVsdCBmdW5jdGlvbiBjcmVhdGVBdXRvSW1wb3J0KCkge1xyXG4gICAgcmV0dXJuIGF1dG9JbXBvcnQoe1xyXG4gICAgICAgIGltcG9ydHM6IFtcclxuICAgICAgICAgICAgJ3Z1ZScsXHJcbiAgICAgICAgICAgICd2dWUtcm91dGVyJyxcclxuICAgICAgICAgICAgJ3BpbmlhJ1xyXG4gICAgICAgIF0sXHJcbiAgICAgICAgZHRzOiBmYWxzZVxyXG4gICAgfSlcclxufVxyXG4iLCAiY29uc3QgX192aXRlX2luamVjdGVkX29yaWdpbmFsX2Rpcm5hbWUgPSBcIkQ6XFxcXHdvcmtcXFxcYW5pbWFsLXN1Y2NvdXJcXFxcdnVlXFxcXHZpdGVcXFxccGx1Z2luc1wiO2NvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9maWxlbmFtZSA9IFwiRDpcXFxcd29ya1xcXFxhbmltYWwtc3VjY291clxcXFx2dWVcXFxcdml0ZVxcXFxwbHVnaW5zXFxcXHN2Zy1pY29uLmpzXCI7Y29uc3QgX192aXRlX2luamVjdGVkX29yaWdpbmFsX2ltcG9ydF9tZXRhX3VybCA9IFwiZmlsZTovLy9EOi93b3JrL2FuaW1hbC1zdWNjb3VyL3Z1ZS92aXRlL3BsdWdpbnMvc3ZnLWljb24uanNcIjtpbXBvcnQgeyBjcmVhdGVTdmdJY29uc1BsdWdpbiB9IGZyb20gJ3ZpdGUtcGx1Z2luLXN2Zy1pY29ucydcclxuaW1wb3J0IHBhdGggZnJvbSAncGF0aCdcclxuXHJcbmV4cG9ydCBkZWZhdWx0IGZ1bmN0aW9uIGNyZWF0ZVN2Z0ljb24oaXNCdWlsZCkge1xyXG4gICAgcmV0dXJuIGNyZWF0ZVN2Z0ljb25zUGx1Z2luKHtcclxuXHRcdGljb25EaXJzOiBbcGF0aC5yZXNvbHZlKHByb2Nlc3MuY3dkKCksICdzcmMvYXNzZXRzL2ljb25zL3N2ZycpXSxcclxuICAgICAgICBzeW1ib2xJZDogJ2ljb24tW2Rpcl0tW25hbWVdJyxcclxuICAgICAgICBzdmdvT3B0aW9uczogaXNCdWlsZFxyXG4gICAgfSlcclxufVxyXG4iLCAiY29uc3QgX192aXRlX2luamVjdGVkX29yaWdpbmFsX2Rpcm5hbWUgPSBcIkQ6XFxcXHdvcmtcXFxcYW5pbWFsLXN1Y2NvdXJcXFxcdnVlXFxcXHZpdGVcXFxccGx1Z2luc1wiO2NvbnN0IF9fdml0ZV9pbmplY3RlZF9vcmlnaW5hbF9maWxlbmFtZSA9IFwiRDpcXFxcd29ya1xcXFxhbmltYWwtc3VjY291clxcXFx2dWVcXFxcdml0ZVxcXFxwbHVnaW5zXFxcXGNvbXByZXNzaW9uLmpzXCI7Y29uc3QgX192aXRlX2luamVjdGVkX29yaWdpbmFsX2ltcG9ydF9tZXRhX3VybCA9IFwiZmlsZTovLy9EOi93b3JrL2FuaW1hbC1zdWNjb3VyL3Z1ZS92aXRlL3BsdWdpbnMvY29tcHJlc3Npb24uanNcIjtpbXBvcnQgY29tcHJlc3Npb24gZnJvbSAndml0ZS1wbHVnaW4tY29tcHJlc3Npb24nXHJcblxyXG5leHBvcnQgZGVmYXVsdCBmdW5jdGlvbiBjcmVhdGVDb21wcmVzc2lvbihlbnYpIHtcclxuICAgIGNvbnN0IHsgVklURV9CVUlMRF9DT01QUkVTUyB9ID0gZW52XHJcbiAgICBjb25zdCBwbHVnaW4gPSBbXVxyXG4gICAgaWYgKFZJVEVfQlVJTERfQ09NUFJFU1MpIHtcclxuICAgICAgICBjb25zdCBjb21wcmVzc0xpc3QgPSBWSVRFX0JVSUxEX0NPTVBSRVNTLnNwbGl0KCcsJylcclxuICAgICAgICBpZiAoY29tcHJlc3NMaXN0LmluY2x1ZGVzKCdnemlwJykpIHtcclxuICAgICAgICAgICAgLy8gaHR0cDovL2RvYy5odWFjYWkudmlwL2h1YWNhaS12dWUvb3RoZXIvZmFxLmh0bWwjXHU0RjdGXHU3NTI4Z3ppcFx1ODlFM1x1NTM4Qlx1N0YyOVx1OTc1OVx1NjAwMVx1NjU4N1x1NEVGNlxyXG4gICAgICAgICAgICBwbHVnaW4ucHVzaChcclxuICAgICAgICAgICAgICAgIGNvbXByZXNzaW9uKHtcclxuICAgICAgICAgICAgICAgICAgICBleHQ6ICcuZ3onLFxyXG4gICAgICAgICAgICAgICAgICAgIGRlbGV0ZU9yaWdpbkZpbGU6IGZhbHNlXHJcbiAgICAgICAgICAgICAgICB9KVxyXG4gICAgICAgICAgICApXHJcbiAgICAgICAgfVxyXG4gICAgICAgIGlmIChjb21wcmVzc0xpc3QuaW5jbHVkZXMoJ2Jyb3RsaScpKSB7XHJcbiAgICAgICAgICAgIHBsdWdpbi5wdXNoKFxyXG4gICAgICAgICAgICAgICAgY29tcHJlc3Npb24oe1xyXG4gICAgICAgICAgICAgICAgICAgIGV4dDogJy5icicsXHJcbiAgICAgICAgICAgICAgICAgICAgYWxnb3JpdGhtOiAnYnJvdGxpQ29tcHJlc3MnLFxyXG4gICAgICAgICAgICAgICAgICAgIGRlbGV0ZU9yaWdpbkZpbGU6IGZhbHNlXHJcbiAgICAgICAgICAgICAgICB9KVxyXG4gICAgICAgICAgICApXHJcbiAgICAgICAgfVxyXG4gICAgfVxyXG4gICAgcmV0dXJuIHBsdWdpblxyXG59XHJcbiJdLAogICJtYXBwaW5ncyI6ICI7QUFBd1EsU0FBUyxjQUFjLGVBQWU7QUFDOVMsT0FBT0EsV0FBVTs7O0FDRHNSLE9BQU8sU0FBUzs7O0FDQUosT0FBTyxnQkFBZ0I7QUFFM1QsU0FBUixtQkFBb0M7QUFDdkMsU0FBTyxXQUFXO0FBQUEsSUFDZCxTQUFTO0FBQUEsTUFDTDtBQUFBLE1BQ0E7QUFBQSxNQUNBO0FBQUEsSUFDSjtBQUFBLElBQ0EsS0FBSztBQUFBLEVBQ1QsQ0FBQztBQUNMOzs7QUNYNlMsU0FBUyw0QkFBNEI7QUFDbFYsT0FBTyxVQUFVO0FBRUYsU0FBUixjQUErQixTQUFTO0FBQzNDLFNBQU8scUJBQXFCO0FBQUEsSUFDOUIsVUFBVSxDQUFDLEtBQUssUUFBUSxRQUFRLElBQUksR0FBRyxzQkFBc0IsQ0FBQztBQUFBLElBQ3hELFVBQVU7QUFBQSxJQUNWLGFBQWE7QUFBQSxFQUNqQixDQUFDO0FBQ0w7OztBQ1RtVCxPQUFPLGlCQUFpQjtBQUU1VCxTQUFSLGtCQUFtQyxLQUFLO0FBQzNDLFFBQU0sRUFBRSxvQkFBb0IsSUFBSTtBQUNoQyxRQUFNLFNBQVMsQ0FBQztBQUNoQixNQUFJLHFCQUFxQjtBQUNyQixVQUFNLGVBQWUsb0JBQW9CLE1BQU0sR0FBRztBQUNsRCxRQUFJLGFBQWEsU0FBUyxNQUFNLEdBQUc7QUFFL0IsYUFBTztBQUFBLFFBQ0gsWUFBWTtBQUFBLFVBQ1IsS0FBSztBQUFBLFVBQ0wsa0JBQWtCO0FBQUEsUUFDdEIsQ0FBQztBQUFBLE1BQ0w7QUFBQSxJQUNKO0FBQ0EsUUFBSSxhQUFhLFNBQVMsUUFBUSxHQUFHO0FBQ2pDLGFBQU87QUFBQSxRQUNILFlBQVk7QUFBQSxVQUNSLEtBQUs7QUFBQSxVQUNMLFdBQVc7QUFBQSxVQUNYLGtCQUFrQjtBQUFBLFFBQ3RCLENBQUM7QUFBQSxNQUNMO0FBQUEsSUFDSjtBQUFBLEVBQ0o7QUFDQSxTQUFPO0FBQ1g7OztBSHJCZSxTQUFSLGtCQUFtQyxTQUFTLFVBQVUsT0FBTztBQUNoRSxRQUFNLGNBQWMsQ0FBQyxJQUFJLENBQUM7QUFDMUIsY0FBWSxLQUFLLGlCQUFpQixDQUFDO0FBQ25DLGNBQVksS0FBSyxjQUFjLE9BQU8sQ0FBQztBQUMxQyxhQUFXLFlBQVksS0FBSyxHQUFHLGtCQUFrQixPQUFPLENBQUM7QUFDdEQsU0FBTztBQUNYOzs7QURaQSxJQUFNLG1DQUFtQztBQUl6QyxJQUFNLFVBQVU7QUFHaEIsSUFBTyxzQkFBUSxhQUFhLENBQUMsRUFBRSxNQUFNLFFBQVEsTUFBTTtBQUNqRCxRQUFNLE1BQU0sUUFBUSxNQUFNLFFBQVEsSUFBSSxDQUFDO0FBQ3ZDLFFBQU0sRUFBRSxhQUFhLElBQUk7QUFDekIsU0FBTztBQUFBO0FBQUE7QUFBQTtBQUFBLElBSUwsTUFBTSxpQkFBaUIsZUFBZSxNQUFNO0FBQUEsSUFDNUMsU0FBUyxrQkFBa0IsS0FBSyxZQUFZLE9BQU87QUFBQSxJQUNuRCxTQUFTO0FBQUE7QUFBQSxNQUVQLE9BQU87QUFBQTtBQUFBLFFBRUwsS0FBS0MsTUFBSyxRQUFRLGtDQUFXLElBQUk7QUFBQTtBQUFBLFFBRWpDLEtBQUtBLE1BQUssUUFBUSxrQ0FBVyxPQUFPO0FBQUEsTUFDdEM7QUFBQTtBQUFBLE1BRUEsWUFBWSxDQUFDLFFBQVEsT0FBTyxPQUFPLFFBQVEsUUFBUSxTQUFTLE1BQU07QUFBQSxJQUNwRTtBQUFBO0FBQUEsSUFFQSxPQUFPO0FBQUE7QUFBQSxNQUVMLFdBQVcsWUFBWSxVQUFVLFFBQVE7QUFBQSxNQUN6QyxRQUFRO0FBQUEsTUFDUixXQUFXO0FBQUEsTUFDWCx1QkFBdUI7QUFBQSxNQUN2QixlQUFlO0FBQUEsUUFDYixRQUFRO0FBQUEsVUFDTixnQkFBZ0I7QUFBQSxVQUNoQixnQkFBZ0I7QUFBQSxVQUNoQixnQkFBZ0I7QUFBQSxRQUNsQjtBQUFBLE1BQ0Y7QUFBQSxJQUNGO0FBQUE7QUFBQSxJQUVBLFFBQVE7QUFBQSxNQUNOLE1BQU07QUFBQSxNQUNOLE1BQU07QUFBQSxNQUNOLE1BQU07QUFBQSxNQUNOLE9BQU87QUFBQTtBQUFBLFFBRUwsWUFBWTtBQUFBLFVBQ1YsUUFBUTtBQUFBLFVBQ1IsY0FBYztBQUFBLFVBQ2QsU0FBUyxDQUFDLE1BQU0sRUFBRSxRQUFRLGNBQWMsRUFBRTtBQUFBLFFBQzVDO0FBQUE7QUFBQSxRQUVDLHNCQUFzQjtBQUFBLFVBQ3JCLFFBQVE7QUFBQSxVQUNSLGNBQWM7QUFBQSxRQUNoQjtBQUFBLE1BQ0Y7QUFBQSxJQUNGO0FBQUEsSUFDQSxLQUFLO0FBQUEsTUFDSCxTQUFTO0FBQUEsUUFDUCxTQUFTO0FBQUEsVUFDUDtBQUFBLFlBQ0UsZUFBZTtBQUFBLFlBQ2YsUUFBUTtBQUFBLGNBQ04sU0FBUyxDQUFDLFdBQVc7QUFDbkIsb0JBQUksT0FBTyxTQUFTLFdBQVc7QUFDN0IseUJBQU8sT0FBTztBQUFBLGdCQUNoQjtBQUFBLGNBQ0Y7QUFBQSxZQUNGO0FBQUEsVUFDRjtBQUFBLFFBQ0Y7QUFBQSxNQUNGO0FBQUEsSUFDRjtBQUFBLEVBQ0Y7QUFDRixDQUFDOyIsCiAgIm5hbWVzIjogWyJwYXRoIiwgInBhdGgiXQp9Cg==
