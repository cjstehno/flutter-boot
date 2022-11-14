package io.github.cjstehno.flutterboot.controller;

import io.github.cjstehno.flutterboot.model.Item;
import lombok.extern.slf4j.Slf4j;
import lombok.val;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.annotation.PostConstruct;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

import static java.util.UUID.randomUUID;

@RestController @Slf4j
public class ItemController {

    private final List<Item> items = new CopyOnWriteArrayList<>();

    @PostConstruct void init() {
        items.addAll(List.of(
            new Item(randomUUID().toString(), "alpha"),
            new Item(randomUUID().toString(), "bravo"),
            new Item(randomUUID().toString(), "charlie")
        ));

        log.info("Populated with {} items.", items.size());
    }

    @GetMapping("/api/items")
    public List<Item> listItems() {
        log.info("Retrieving {} items", items.size());
        return items;
    }

    @GetMapping("/api/items/{id}")
    public Item fetchItem(@PathVariable(value = "id", required = false) final String id) {
        log.info("Retrieving item ({}).", id);
        return items.stream().filter(it -> it.getId().equals(id)).findAny().orElseThrow();
    }

    @DeleteMapping("/api/items/{id}")
    public ResponseEntity<Void> deleteItem(@PathVariable(value = "id", required = false) final String id) {
        log.info("Deleting item ({}).", id);

        items.stream().filter(it -> it.getId().equals(id)).findAny().ifPresent(items::remove);

        return ResponseEntity.ok(null);
    }

    @PostMapping("/api/items")
    public Item saveItem(@RequestBody final Item item) {
        val newItem = new Item(randomUUID().toString(), item.getValue());
        items.add(newItem);
        return newItem;
    }
}
