# InfiniteScrollContainer
When you have to show a lot of items, instead of continuously generating nodes, you only need to change the data with a set node.

In the example, only 10 container objects are created and reused when scrolling.

If you download the project, you don't need to set it up.

*somtimes, you need to set options

<img src=./Jungleprog/Asset/option.png>

*mouse filter option use pass

<img src=./Jungleprog/Asset/mouse.png>


*Only V Scroll you can change H Scroll. Easy~

*if you want use in mobile, you should change function in the script InfiniteScrollContainer.gd
  _on_gui_input(event) -> _input(event)
  
  on_gui_input(event) to event.relative is not working well, because scroll container
