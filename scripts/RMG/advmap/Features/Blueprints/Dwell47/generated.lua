--- Параметры постройки двеллингов 1-3 уровня

BLUEPRINTS_DWELL_47 = {
    -- Орден Порядка
    [TOWN_HEAVEN] = {
        path = "/Text/Game/TownBuildings/Haven/",
        -- Грифоны
        [TOWN_BUILDING_DWELLING_4] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_4/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 5,
                        [MERCURY] = 1,
                        [GOLD] = 3000
                    }
                },
                [2] = {
                    name = "Dwelling_4/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 15,
                        [MERCURY] = 4,
                        [CRYSTAL] = 2,
                        [GOLD] = 3000
                    }
                }
            }
        },
        -- Монахи
        [TOWN_BUILDING_DWELLING_5] = {
            town_level = 10,
            depends_on = {[TOWN_BUILDING_MAGIC_GUILD] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_5/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [CRYSTAL] = 3,
                        [SULFUR] = 3,
                        [GEM] = 3,
                        [GOLD] = 4000
                    }
                },
                [2] = {
                    name = "Dwelling_5/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 8,
                        [CRYSTAL] = 5,
                        [GEM] = 5,
                        [GOLD] = 7000
                    }
                }
            }
        },
        -- Кони
        [TOWN_BUILDING_DWELLING_6] = {
            town_level = 10,
            depends_on = {[TOWN_BUILDING_HAVEN_STABLE] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_6/Name.txt",
                    cost = {
                        [WOOD] = 15,
                        [CRYSTAL] = 8,
                        [GOLD] = 5600
                    }
                },
                [2] = {
                    name = "Dwelling_6/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 20,
                        [CRYSTAL] = 14,
                        [SULFUR] = 5,
                        [GOLD] = 7500
                    }
                }
            }
        },
        -- Ангелы
        [TOWN_BUILDING_DWELLING_7] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_7/Name.txt",
                    cost = {
                        [ORE] = 15,
                        [CRYSTAL] = 5,
                        [GEM] = 5,
                        [GOLD] = 7000
                    }
                },
                [2] = {
                    name = "Dwelling_7/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 20,
                        [SULFUR] = 6,
                        [GEM] = 12,
                        [GOLD] = 8800
                    }
                }
            }
        }
    },
    -- Академия
    [TOWN_ACADEMY] = {
        path = "/Text/Game/TownBuildings/Academy/",
        -- Маги
        [TOWN_BUILDING_DWELLING_4] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_4/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 10,
                        [SULFUR] = 4,
                        [GEM] = 4,
                        [GOLD] = 2200
                    }
                },
                [2] = {
                    name = "Dwelling_4/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [CRYSTAL] = 7,
                        [SULFUR] = 5,
                        [GEM] = 5,
                        [GOLD] = 3000
                    }
                }
            }
        },
        -- Джинны
        [TOWN_BUILDING_DWELLING_5] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_5/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 6,
                        [GEM] = 3,
                        [GOLD] = 2500
                    }
                },
                [2] = {
                    name = "Dwelling_5/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 10,
                        [MERCURY] = 10,
                        [CRYSTAL] = 2,
                        [SULFUR] = 4,
                        [GOLD] = 4600
                    }
                }
            }
        },
        -- Ракшасы
        [TOWN_BUILDING_DWELLING_6] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_6/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [CRYSTAL] = 7,
                        [GEM] = 7,
                        [GOLD] = 5250
                    }
                },
                [2] = {
                    name = "Dwelling_6/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [CRYSTAL] = 9,
                        [SULFUR] = 12,
                        [GOLD] = 6200
                    }
                }
            }
        },
        -- Титаны
        [TOWN_BUILDING_DWELLING_7] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_7/Name.txt",
                    cost = {
                        [WOOD] = 12,
                        [ORE] = 12,
                        [GEM] = 10,
                        [GOLD] = 8600
                    }
                },
                [2] = {
                    name = "Dwelling_7/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 15,
                        [MERCURY] = 12,
                        [GEM] = 15,
                        [GOLD] = 10000
                    }
                }
            }
        },
    },
    -- Лига
    [TOWN_DUNGEON] = {
        path = "/Text/Game/TownBuildings/Dungeon/",
        -- Ящеры
        [TOWN_BUILDING_DWELLING_4] = {
            town_level = 8,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_4/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [SULFUR] = 5,
                        [GOLD] = 2000
                    }
                },
                [2] = {
                    name = "Dwelling_4/Upgraded_Name.txt",
                    cost = {
                        [MERCURY] = 2,
                        [CRYSTAL] = 4,
                        [SULFUR] = 4,
                        [GOLD] = 3400
                    }
                }
            }
        },
        -- Гидры
        [TOWN_BUILDING_DWELLING_5] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_5/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [CRYSTAL] = 3,
                        [GEM] = 5,
                        [GOLD] = 2500
                    }
                },
                [2] = {
                    name = "Dwelling_5/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 4,
                        [CRYSTAL] = 4,
                        [GEM] = 4,
                        [GOLD] = 4000
                    }
                }
            }
        },
        -- Ведьмы
        [TOWN_BUILDING_DWELLING_6] = {
            town_level = 10,
            depends_on = {[TOWN_BUILDING_DUNGEON_HALL_OF_INTRIGUE] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_6/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 3,
                        [CRYSTAL] = 2,
                        [SULFUR] = 3,
                        [GEM] = 2,
                        [GOLD] = 4000
                    }
                },
                [2] = {
                    name = "Dwelling_6/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 5,
                        [CRYSTAL] = 5,
                        [SULFUR] = 5,
                        [GEM] = 5,
                        [GOLD] = 5000
                    }
                }
            }
        },
        -- Драконы
        [TOWN_BUILDING_DWELLING_7] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_7/Name.txt",
                    cost = {
                        [ORE] = 15,
                        [CRYSTAL] = 10,
                        [GOLD] = 8000
                    }
                },
                [2] = {
                    name = "Dwelling_7/Upgraded_Name.txt",
                    cost = {
                        [MERCURY] = 8,
                        [SULFUR] = 20,
                        [GEM] = 8,
                        [GOLD] = 12500
                    }
                }
            }
        }
    },
    -- Гномы
    [TOWN_FORTRESS] = {
        path = "/Text/Game/TownBuildings/Dwarves/",
        -- Берсы
        [TOWN_BUILDING_DWELLING_4] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_4/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 4,
                        [GEM] = 4,
                        [GOLD] = 2000
                    }
                },
                [2] = {
                    name = "Dwelling_4/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [MERCURY] = 6,
                        [GEM] = 6,
                        [GOLD] = 3500
                    }
                }
            }
        },
        -- Жрецы
        [TOWN_BUILDING_DWELLING_5] = {
            town_level = 10,
            depends_on = {[TOWN_BUILDING_FORTRESS_RUNIC_ACADEMY] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_5/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 2,
                        [CRYSTAL] = 3,
                        [SULFUR] = 2,
                        [GEM] = 3,
                        [GOLD] = 3000
                    }
                },
                [2] = {
                    name = "Dwelling_5/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 10,
                        [MERCURY] = 3,
                        [CRYSTAL] = 3,
                        [SULFUR] = 7,
                        [GEM] = 7,
                        [GOLD] = 4650
                    }
                }
            }
        },
        -- Таны
        [TOWN_BUILDING_DWELLING_6] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_6/Name.txt",
                    cost = {
                        [CRYSTAL] = 10,
                        [GOLD] = 5000
                    }
                },
                [2] = {
                    name = "Dwelling_6/Upgraded_Name.txt",
                    cost = {
                        [CRYSTAL] = 16,
                        [GEM] = 12,
                        [GOLD] = 6600
                    }
                }
            }
        },
        -- Драконы
        [TOWN_BUILDING_DWELLING_7] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_7/Name.txt",
                    cost = {
                        [ORE] = 15,
                        [MERCURY] = 5,
                        [SULFUR] = 10,
                        [GOLD] = 8000
                    }
                },
                [2] = {
                    name = "Dwelling_7/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 20,
                        [MERCURY] = 10,
                        [SULFUR] = 10,
                        [GOLD] = 10000
                    }
                }
            }
        }
    },
    -- Демоны
    [TOWN_INFERNO] = {
        path = "/Text/Game/TownBuildings/Inferno/",
        -- Суккубы
        [TOWN_BUILDING_DWELLING_4] = {
            town_level = 8,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_4/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 3,
                        [SULFUR] = 3,
                        [GOLD] = 2350
                    }
                },
                [2] = {
                    name = "Dwelling_4/Upgraded_Name.txt",
                    cost = {
                        [MERCURY] = 5,
                        [CRYSTAL] = 4,
                        [SULFUR] = 5,
                        [GEM] = 4,
                        [GOLD] = 4300
                    }
                }
            }
        },
        -- Кошмары
        [TOWN_BUILDING_DWELLING_5] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_5/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [CRYSTAL] = 6,
                        [SULFUR] = 4,
                        [GOLD] = 4100
                    }
                },
                [2] = {
                    name = "Dwelling_5/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 2,
                        [SULFUR] = 6,
                        [GEM] = 8,
                        [GOLD] = 4800
                    }
                }
            }
        },
        -- Питы
        [TOWN_BUILDING_DWELLING_6] = {
            town_level = 10,
            depends_on = {[TOWN_BUILDING_MAGIC_GUILD] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_6/Name.txt",
                    cost = {
                        [ORE] = 10,
                        [MERCURY] = 7,
                        [GOLD] = 5300
                    }
                },
                [2] = {
                    name = "Dwelling_6/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 10,
                        [MERCURY] = 10,
                        [CRYSTAL] = 8,
                        [GEM] = 8,
                        [GOLD] = 5450
                    }
                }
            }
        },
        -- Дьяволы
        [TOWN_BUILDING_DWELLING_7] = {
            town_level = 10,
            depends_on = {[TOWN_BUILDING_MAGIC_GUILD] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_7/Name.txt",
                    cost = {
                        [ORE] = 10,
                        [MERCURY] = 8,
                        [SULFUR] = 4,
                        [GOLD] = 6000
                    }
                },
                [2] = {
                    name = "Dwelling_7/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 13,
                        [SULFUR] = 13,
                        [GOLD] = 11000
                    }
                }
            }
        }
    },
    -- Некры
    [TOWN_NECROMANCY] = {
        path = "/Text/Game/TownBuildings/Necromancy/",
        -- Вампиры
        [TOWN_BUILDING_DWELLING_4] = {
            town_level = 8,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_4/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 10,
                        [MERCURY] = 2,
                        [SULFUR] = 2,
                        [GOLD] = 2650
                    }
                },
                [2] = {
                    name = "Dwelling_4/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 15,
                        [CRYSTAL] = 6,
                        [GEM] = 6,
                        [GOLD] = 3400
                    }
                }
            }
        },
        -- Личи
        [TOWN_BUILDING_DWELLING_5] = {
            town_level = 10,
            depends_on = {[TOWN_BUILDING_MAGIC_GUILD] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_5/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 10,
                        [MERCURY] = 2,
                        [CRYSTAL] = 2,
                        [SULFUR] = 2,
                        [GEM] = 2,
                        [GOLD] = 3500
                    }
                },
                [2] = {
                    name = "Dwelling_5/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 10,
                        [MERCURY] = 3,
                        [CRYSTAL] = 6,
                        [SULFUR] = 8,
                        [GEM] = 6,
                        [GOLD] = 4000
                    }
                }
            }
        },
        -- Баньши
        [TOWN_BUILDING_DWELLING_6] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_6/Name.txt",
                    cost = {
                        [WOOD] = 7,
                        [ORE] = 7,
                        [MERCURY] = 8,
                        [GOLD] = 4000
                    }
                },
                [2] = {
                    name = "Dwelling_6/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 10,
                        [CRYSTAL] = 5,
                        [GEM] = 8,
                        [GOLD] = 7000
                    }
                }
            }
        },
        -- Драконы
        [TOWN_BUILDING_DWELLING_7] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_7/Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 10,
                        [MERCURY] = 10,
                        [GOLD] = 5800
                    }
                },
                [2] = {
                    name = "Dwelling_7/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 15,
                        [ORE] = 15,
                        [MERCURY] = 10,
                        [SULFUR] = 6,
                        [GOLD] = 7000
                    }
                }
            }
        }
    },
    -- Эльфы
    [TOWN_PRESERVE] = {
        path = "/Text/Game/TownBuildings/Preserve/",
        -- Друиды
        [TOWN_BUILDING_DWELLING_4] = {
            town_level = 8,
            depends_on = {[TOWN_BUILDING_MAGIC_GUILD] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_4/Name.txt",
                    cost = {
                        [ORE] = 10,
                        [CRYSTAL] = 3,
                        [GEM] = 3,
                        [GOLD] = 1600
                    }
                },
                [2] = {
                    name = "Dwelling_4/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 10,
                        [CRYSTAL] = 6,
                        [GEM] = 6,
                        [GOLD] = 3650
                    }
                }
            }
        },
        -- Единороги
        [TOWN_BUILDING_DWELLING_5] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_5/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [CRYSTAL] = 5,
                        [GEM] = 5,
                        [GOLD] = 3500
                    }
                },
                [2] = {
                    name = "Dwelling_5/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [CRYSTAL] = 9,
                        [GEM] = 9,
                        [GOLD] = 4500
                    }
                }
            }
        },
        -- Энты
        [TOWN_BUILDING_DWELLING_6] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_6/Name.txt",
                    cost = {
                        [WOOD] = 12,
                        [MERCURY] = 5,
                        [SULFUR] = 5,
                        [GEM] = 3,
                        [GOLD] = 4800
                    }
                },
                [2] = {
                    name = "Dwelling_6/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 15,
                        [MERCURY] = 4,
                        [CRYSTAL] = 8,
                        [SULFUR] = 5,
                        [GOLD] = 6000
                    }
                }
            }
        },
        -- Драконы
        [TOWN_BUILDING_DWELLING_7] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_7/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [CRYSTAL] = 10,
                        [GEM] = 5,
                        [GOLD] = 7000
                    }
                },
                [2] = {
                    name = "Dwelling_7/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 10,
                        [CRYSTAL] = 15,
                        [GEM] = 12,
                        [GOLD] = 10000
                    }
                }
            }
        }
    },
    -- Орки
    [TOWN_STRONGHOLD] = {
        path = "/Text/Game/TownBuildings/StrongHold/",
        -- Гоблины
        [TOWN_BUILDING_DWELLING_4] = {
            town_level = 6,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_4/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [MERCURY] = 3,
                        [CRYSTAL] = 4,
                        [SULFUR] = 4,
                        [GOLD] = 3200
                    }
                },
                [2] = {
                    name = "Dwelling_4/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 5,
                        [MERCURY] = 5,
                        [SULFUR] = 6,
                        [GEM] = 6,
                        [GOLD] = 1500
                    }
                }
            }
        },
        -- Кентавры
        [TOWN_BUILDING_DWELLING_5] = {
            town_level = 9,
            depends_on = {[TOWN_BUILDING_DWELLING_3] = 1},
            upgrades = {
                [1] = {
                    name = "Dwelling_5/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 10,
                        [MERCURY] = 5,
                        [GOLD] = 3800
                    }
                },
                [2] = {
                    name = "Dwelling_5/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 10,
                        [ORE] = 15,
                        [CRYSTAL] = 8,
                        [GEM] = 10,
                        [GOLD] = 4500
                    }
                }
            }
        },
        -- Бойцы
        [TOWN_BUILDING_DWELLING_6] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_6/Name.txt",
                    cost = {
                        [WOOD] = 15,
                        [SULFUR] = 5,
                        [GOLD] = 4500
                    }
                },
                [2] = {
                    name = "Dwelling_6/Upgraded_Name.txt",
                    cost = {
                        [WOOD] = 15,
                        [ORE] = 10,
                        [MERCURY] = 7,
                        [SULFUR] = 10,
                        [GOLD] = 7000
                    }
                }
            }
        },
        -- Бойцы
        [TOWN_BUILDING_DWELLING_7] = {
            town_level = 10,
            depends_on = nil,
            upgrades = {
                [1] = {
                    name = "Dwelling_7/Name.txt",
                    cost = {
                        [WOOD] = 5,
                        [ORE] = 10,
                        [MERCURY] = 5,
                        [CRYSTAL] = 6,
                        [GEM] = 6,
                        [GOLD] = 9000
                    }
                },
                [2] = {
                    name = "Dwelling_7/Upgraded_Name.txt",
                    cost = {
                        [ORE] = 25,
                        [MERCURY] = 10,
                        [CRYSTAL] = 15,
                        [GEM] = 5,
                        [GOLD] = 11000
                    }
                }
            }
        }
    }
}