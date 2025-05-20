# ParsecWarpforfree

**ParsecWarpforfree** is a simple tool that leverages a [mitmproxy](https://mitmproxy.org/) instance to intercept and modify the API responses of Parsec. Specifically, it tricks the Parsec client into thinking the **Warp feature** is enabled, even without a paid subscription.

---

## 🚀 How It Works

1. A custom mitmproxy instance is started.
2. This instance intercepts the Parsec API response related to the Warp feature.
3. It modifies the response, changing `"warp": false` to `"warp": true`.
4. As long as mitmproxy is running, Parsec displays the Warp feature as enabled in the UI.

---

## ⚙️ Prerequisites

### Install mitmproxy

You need to have mitmproxy installed for this to work.

#### Installation:

- **Windows:**
  ```bash
  pip install mitmproxy

> ⚠️ **Warning:** Be sure to have the mitmproxy CA installed to be able to decrypt HTTPS traffic


## Potential Todo:
Patch the parsec DLL to dinamycally set the key to True when its received
