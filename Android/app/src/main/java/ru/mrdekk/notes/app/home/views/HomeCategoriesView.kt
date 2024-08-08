package ru.mrdekk.notes.app.home.views

import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import ru.mrdekk.notes.generic.models.Category
import ru.mrdekk.notes.generic.models.makeDummyCategories

@Composable
fun HomeCategoriesView(categories: List<Category>) {
    LazyColumn(modifier = Modifier.padding(8.dp)) {
        items(categories) { category ->
            HomeCategoryView(
                category = category,
                modifier = Modifier.padding(bottom = 8.dp)
            )
        }
    }
}

@Preview
@Composable
fun HomeCategoriesViewPreview() {
    HomeCategoriesView(categories = makeDummyCategories())
}

//    List {
//        ForEach($categories) { category in
//            HomeCategoryView(category: category)
//                .listRowSeparator(.hidden)
//        .listRowBackground(
//            RoundedRectangle(cornerRadius: 5)
//            .background(Color.clear)
//            .foregroundColor(Color.white)
//            .padding(
//                EdgeInsets(
//                    top: 2,
//                leading: 10,
//        bottom: 8,
//        trailing: 10
//        )
//        )
//        )
//
//    }
//    }
//        .listStyle(.plain)
//    .background(Color(white: 0.95))
//}
