return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "2019.10.18",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 100,
  height = 100,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 9,
  nextobjectid = 22,
  backgroundcolor = { 0, 0, 0 },
  properties = {},
  tilesets = {
    {
      name = "markers",
      firstgid = 1,
      filename = "../img/markers.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 2,
      margin = 1,
      columns = 1,
      image = "../img/markers.png",
      imagewidth = 18,
      imageheight = 18,
      transparentcolor = "#000000",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 1,
      tiles = {}
    },
    {
      name = "tiles",
      firstgid = 2,
      filename = "../img/tiles.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 2,
      margin = 1,
      columns = 2,
      image = "../img/tiles.png",
      imagewidth = 36,
      imageheight = 18,
      transparentcolor = "#000000",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 2,
      tiles = {
        {
          id = 0,
          properties = {
            ["collidable"] = true
          },
          objectGroup = {
            type = "objectgroup",
            id = 2,
            name = "",
            visible = true,
            opacity = 1,
            offsetx = 0,
            offsety = 0,
            draworder = "index",
            properties = {},
            objects = {
              {
                id = 1,
                name = "",
                type = "",
                shape = "rectangle",
                x = 0,
                y = 0,
                width = 16.0514,
                height = 3.41897,
                rotation = 0,
                visible = true,
                properties = {}
              }
            }
          }
        },
        {
          id = 1,
          properties = {
            ["collidable"] = true,
            ["platform"] = true
          }
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 3,
      name = "world",
      x = 0,
      y = 0,
      width = 100,
      height = 100,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAHt0dEKhCAQBdBo//+ftx4EMYi62whLR5DKnLHOXZdlWSfO7SjjRGDPIhlXMkz6vr0mzePtblX/L48q2ayvPDK3qip5VMlmfeWRuVVVyaNKNusrj8ytqkoeVbJZX3lkblVV8qiSzfo+kcfeY5yfbW2fxj2BX/IYM2jP977A7l5gRh5y6sXP76/m0Uz7/f1afz+e2N6N656PAs1qxvV4uhUCBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAAECBAgQIECAAIF/F/gC0ggA4Q=="
    },
    {
      type = "objectgroup",
      id = 7,
      name = "markers",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 304,
          y = 192,
          width = 16,
          height = 16,
          rotation = 0,
          gid = 1,
          visible = true,
          properties = {
            ["type"] = "start"
          }
        }
      }
    }
  }
}
