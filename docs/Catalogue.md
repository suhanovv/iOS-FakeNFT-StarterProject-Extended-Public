# Catalogue

[ссылка на эпик](https://github.com/suhanovv/iOS-FakeNFT-StarterProject-Extended-Public/issues/3)

## Milestone 1/3 (Estimate Time: 30h / Fact Time: 21h)

- Перенести ассеты в проект 
  (Estimate Time: 1h / Fact Time: 1h)

- Описать DTO для коллекций и NFT  
  (Estimate Time: 5h / Fact Time: 4h)

- Сверстать компонент "карточка коллекции" для экрана каталога  
  (обложка, название, количество NFT)  
  (Estimate Time: 4h / Fact Time: 1h)

- Сверстать компонент "ячейка NFT" для грида на экране коллекции  
  (изображение, название, рейтинг, стоимость; без логики избранного и корзины)  
  (Estimate Time: 4h / Fact Time: 3h)

- Сверстать базовый layout экрана "Каталог": список (List) коллекций из нескольких заглушечных элементов "карточка коллекции"  
  (Estimate Time: 8h / Fact Time: 4h)

- Сверстать базовый layout экрана "Коллекция": верхняя часть + грид NFT из нескольких элементов "ячейка NFT"  
  (Estimate Time: 6h / Fact Time: 6h)

- Настроить простую навигацию: переход с экрана "Каталог" на экран "Коллекция" по тапу на коллекцию 
  (Estimate Time: 2h / Fact Time: 2h)


## Milestone 2/3 (Estimate Time: 23h / Fact Time: 19h)

- Описать модели для коллекций и NFT, с которыми будет работать UI  
  (Estimate Time: 4h / Fact Time: 3h)

- Настроить ViewModel для экрана "Каталог":  
  - список коллекций  
  - выбранный тип сортировки  
  - связь View ↔ ViewModel
  (Estimate Time: 5h / Fact Time: 3h)

- Настроить ViewModel для экрана "Коллекция":  
  - данные коллекции  
  - список NFT  
  - связь View ↔ ViewModel  
  (Estimate Time: 4h / Fact Time: 3h)

- Сверстать и подключить UI выбора сортировки на экране каталога  
  (Estimate Time: 4h / Fact Time: 4h)

- Реализовать логику сортировки коллекций на экране "Каталог":  
  - по названию  
  - по количеству NFT (значение по умолчанию)  
  (Estimate Time: 4h / Fact Time: 4h)

- Реализовать сохранение выбранного типа сортировки только для каталога через `@AppStorage` / `UserDefaults` и восстановление после перезапуска  
  (Estimate Time: 2h / Fact Time: 2h)


## Milestone 3/3 (Estimate Time: 24h / Fact Time:)

- Реализовать сетевой сервис загрузки списка коллекций через `actor`  
  - запросы с использованием `async/await`  
  - данные помечены `Sendable`  
  (Estimate Time: 6h / Fact Time: )

- Реализовать сетевой сервис загрузки данных конкретной коллекции через отдельный `actor`  
  (Estimate Time: 6h / Fact Time: )

- Интегрировать сетевые сервисы с ViewModel экрана "Каталог":  
  - загрузка данных  
  - отображение `ProgressView` во время загрузки  
  (Estimate Time: 4h / Fact Time: )

- Интегрировать сетевые сервисы с ViewModel экрана "Коллекция":  
  - загрузка деталей коллекции и NFT  
  - отображение `ProgressView` во время загрузки  
  (Estimate Time: 4h / Fact Time: )

- Проверить корректную работу многопоточности:  
  - обновление UI только из `@MainActor`  
  - отсутствие GCD и completion-handler-ов  
  - при необходимости использование `async let` / `withTaskGroup`  
  (Estimate Time: 4h / Fact Time: )
