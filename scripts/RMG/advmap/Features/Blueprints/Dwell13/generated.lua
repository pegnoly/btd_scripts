--- Параметры постройки двеллингов 1-3 уровня

BLUEPRINTS_DWELL_13 = {
    -- Орден Порядка
    [TOWN_HEAVEN] = {
        path = "/Text/Game/TownBuildings/Haven/",
        -- Крестьянские хижины
        [TOWN_BUILDING_DWELLING_1] = {
            town_level = 1,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_1/Name.txt",
                    cost = {
                        [GOLD] = 500
                    }
                },
                [2] = {
                    name = "Dwelling_1/Upgraded_Name.txt",
                    cost = {
                        [GOLD] = 1500
                    }
                }
            }
        },
        -- Башня лучников
        [TOWN_BUILDING_DWELLING_2] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_2/Name.txt",
                    cost = {
                        [ORE] = 10,
                        [GOLD] = 1200
                    }
                },
                [2] = {
                    name = "Dwelling_2/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 10,
                        [GOLD] = 2700
                    }
                }
            }
        },
        -- Казармы
        [TOWN_BUILDING_DWELLING_3] = {
            town_level = 3,
            depends_on = {[TOWN_BUILDING_BLACKSMITH] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_3/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 6,
                        [GOLD] = 1500
                    }
                },
                [2] = {
                    name = "Dwelling_3/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 10,
                        [MERCURY] = 2,
                        [GOLD] = 3000
                    }
                }
            }
        }
    },
    -- Академия
    [TOWN_ACADEMY] = {
        path = "/Text/Game/TownBuildings/Academy/",
        -- Гремлины
        [TOWN_BUILDING_DWELLING_1] = {
            town_level = 1,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_1/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 500
                    }
                },
                [2] = {
                    name = "Dwelling_1/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 1500
                    }
                }
            }
        },
        -- Гаргульи
        [TOWN_BUILDING_DWELLING_2] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_2/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 1200
                    }
                },
                [2] = {
                    name = "Dwelling_2/Upgraded_Name.txt",
                    cost = {
                        [GOLD] = 2400
                    }
                }
            }
        },
        -- Големы
        [TOWN_BUILDING_DWELLING_3] = {
            town_level = 3,
            depends_on = {[TOWN_BUILDING_BLACKSMITH] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_3/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 2,
                        [GOLD] = 1500
                    }
                },
                [2] = {
                    name = "Dwelling_3/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 3,
                        [GEM] = 4,
                        [GOLD] = 2500
                    }
                }
            }
        },
    },
    -- Лига
    [TOWN_DUNGEON] = {
        path = "/Text/Game/TownBuildings/Dungeon/",
        -- Лазутчики
        [TOWN_BUILDING_DWELLING_1] = {
            town_level = 1,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_1/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 400
                    }
                },
                [2] = {
                    name = "Dwelling_1/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 1200
                    }
                }
            }
        },
        -- Бестии
        [TOWN_BUILDING_DWELLING_2] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_2/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 1000
                    }
                },
                [2] = {
                    name = "Dwelling_2/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 5,
                        [CRYSTAL] = 3,
                        [GOLD] = 2500
                    }
                }
            }
        },
        -- Минотавры
        [TOWN_BUILDING_DWELLING_3] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_3/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 10,
                        [GOLD] = 1200
                    }
                },
                [2] = {
                    name = "Dwelling_3/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 10,
                        [SULFUR] = 5,
                        [GOLD] = 2500
                    }
                }
            }
        }
    },
    -- Гномы
    [TOWN_FORTRESS] = {
        path = "/Text/Game/TownBuildings/Dwarves/",
        -- Защитники
        [TOWN_BUILDING_DWELLING_1] = {
            town_level = 1,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_1/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 400
                    }
                },
                [2] = {
                    name = "Dwelling_1/Upgraded_Name.txt",
                    cost = {
                        [GOLD] = 1200
                    }
                }
            }
        },
        -- Метатели
        [TOWN_BUILDING_DWELLING_2] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_2/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [GOLD] = 1000
                    }
                },
                [2] = {
                    name = "Dwelling_2/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [CRYSTAL] = 3,
                        [GOLD] = 1800
                    }
                }
            }
        },
        -- Медведи
        [TOWN_BUILDING_DWELLING_3] = {
            town_level = 6,
            depends_on = {[TOWN_BUILDING_DWELLING_1] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_3/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 5,
                        [GOLD] = 1200
                    }
                },
                [2] = {
                    name = "Dwelling_3/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 10,
                        [MERCURY] = 2,
                        [GOLD] = 2400
                    }
                }
            }
        }
    },
    -- Демоны
    [TOWN_INFERNO] = {
        path = "/Text/Game/TownBuildings/Inferno/",
        -- Черти
        [TOWN_BUILDING_DWELLING_1] = {
            town_level = 1,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_1/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 400
                    }
                },
                [2] = {
                    name = "Dwelling_1/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 3,
                        [MERCURY] = 1,
                        [GOLD] = 1200
                    }
                }
            }
        },
        -- Демоны
        [TOWN_BUILDING_DWELLING_2] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_2/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 1000
                    }
                },
                [2] = {
                    name = "Dwelling_2/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 5,
                        [GOLD] = 2200
                    }
                }
            }
        },
        -- Собаки
        [TOWN_BUILDING_DWELLING_3] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_3/Name.txt",
                    cost = {
                        [WOOD] = 6,
                        [ORE] = 6,
                        [SULFUR] = 3,
                        [GOLD] = 1200
                    }
                },
                [2] = {
                    name = "Dwelling_3/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 15,
                        [SULFUR] = 5,
                        [GOLD] = 2450
                    }
                }
            }
        }
    },
    -- Некры
    [TOWN_NECROMANCY] = {
        path = "/Text/Game/TownBuildings/Necromancy/",
        -- Скелеты
        [TOWN_BUILDING_DWELLING_1] = {
            town_level = 1,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_1/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 300
                    }
                },
                [2] = {
                    name = "Dwelling_1/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 900
                    }
                }
            }
        },
        -- Зомби
        [TOWN_BUILDING_DWELLING_2] = {
            town_level = 3,
            depends_on = {[TOWN_BUILDING_TOWN_HALL] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_2/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 800
                    }
                },
                [2] = {
                    name = "Dwelling_2/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 3,
                        [ORE] = 3,
                        [MERCURY] = 2,
                        [GOLD] = 1750
                    }
                }
            }
        },
        -- Призраки
        [TOWN_BUILDING_DWELLING_3] = {
            town_level = 6,
            depends_on = {[TOWN_BUILDING_NECROMANCY_AMPLIFIER] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_3/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 3,
                        [GOLD] = 1800
                    }
                },
                [2] = {
                    name = "Dwelling_3/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 7,
                        [MERCURY] = 4,
                        [GOLD] = 2000
                    }
                }
            }
        }
    },
    -- Эльфы
    [TOWN_PRESERVE] = {
        path = "/Text/Game/TownBuildings/Preserve/",
        -- Феи
        [TOWN_BUILDING_DWELLING_1] = {
            town_level = 1,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_1/Name.txt",
                    cost = {
                        [WOOD] = 4,
                        [GOLD] = 300
                    }
                },
                [2] = {
                    name = "Dwelling_1/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 900
                    }
                }
            }
        },
        -- Танцы
        [TOWN_BUILDING_DWELLING_2] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_2/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [GOLD] = 1100
                    }
                },
                [2] = {
                    name = "Dwelling_2/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 10,
                        [CRYSTAL] = 2,
                        [GOLD] = 1750
                    }
                }
            }
        },
        -- Лучники
        [TOWN_BUILDING_DWELLING_3] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_3/Name.txt",
                    cost = {
                        [WOOD] = 12,
                        [ORE] = 5,
                        [GOLD] = 1500
                    }
                },
                [2] = {
                    name = "Dwelling_3/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 15,
                        [GEM] = 5,
                        [GOLD] = 2000
                    }
                }
            }
        }
    },
    -- Орки
    [TOWN_STRONGHOLD] = {
        path = "/Text/Game/TownBuildings/StrongHold/",
        -- Гоблины
        [TOWN_BUILDING_DWELLING_1] = {
            town_level = 1,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_1/Name.txt",
                    cost = {
                        [GOLD] = 400
                    }
                },
                [2] = {
                    name = "Dwelling_1/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 1500
                    }
                }
            }
        },
        -- Кентавры
        [TOWN_BUILDING_DWELLING_2] = {
            town_level = 3,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_2/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [GOLD] = 1100
                    }
                },
                [2] = {
                    name = "Dwelling_2/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [MERCURY] = 3,
                        [SULFUR] = 1,
                        [GOLD] = 2300
                    }
                }
            }
        },
        -- Бойцы
        [TOWN_BUILDING_DWELLING_3] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_3/Name.txt",
                    cost = {
                        [ORE] = 5,
                        [GOLD] = 2000
                    }
                },
                [2] = {
                    name = "Dwelling_3/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 10,
                        [GEM] = 4,
                        [GOLD] = 3100
                    }
                }
            }
        }
    }
}