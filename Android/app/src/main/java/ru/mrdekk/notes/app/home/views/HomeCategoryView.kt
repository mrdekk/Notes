package ru.mrdekk.notes.app.home.views

import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.material.Card
import androidx.compose.material.Divider
import androidx.compose.material.Icon
import androidx.compose.material.Text
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.outlined.AccountCircle
import androidx.compose.material.icons.outlined.ArrowForwardIos
import androidx.compose.material.icons.outlined.CalendarMonth
import androidx.compose.material.icons.outlined.ChevronRight
import androidx.compose.material.icons.outlined.Timer
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import ru.mrdekk.notes.generic.models.Category
import ru.mrdekk.notes.generic.models.Time
import ru.mrdekk.notes.generic.models.localizedId
import ru.mrdekk.notes.generic.models.makeDummyCategories
import java.util.concurrent.TimeUnit

@Composable
fun HomeCategoryView(
    category: Category,
    modifier: Modifier = Modifier
) {
    Card(modifier = modifier) {
        Column(modifier = Modifier.padding(16.dp)) {
            Row(verticalAlignment = Alignment.CenterVertically) {
                Icon(
                    imageVector = Icons.Outlined.ChevronRight,
                    contentDescription = null,
                    tint = category.color.composeColor,
                    modifier = Modifier.padding(end = 8.dp)
                )
                Text(text = category.title.take(60))
            }
            Divider(modifier = Modifier.padding(top = 8.dp, bottom = 8.dp))
            Row(verticalAlignment = Alignment.Top) {
                Column(horizontalAlignment = Alignment.Start) {
                    Row(
                        modifier = Modifier.padding(bottom = 2.dp),
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        Icon(
                            imageVector = Icons.Outlined.CalendarMonth,
                            contentDescription = null,
                            modifier = Modifier.padding(end = 8.dp)
                        )
                        Text(
                            category.schedule
                                .localizedId()
                                .map { stringResource(id = it) }
                                .joinToString(separator = ", "),
                            textAlign = TextAlign.Start,
                            fontWeight = FontWeight.Thin
                        )
                    }
                    Row(verticalAlignment = Alignment.CenterVertically) {
                        Icon(
                            imageVector = Icons.Outlined.Timer,
                            contentDescription = null,
                            modifier = Modifier.padding(end = 8.dp)
                        )
                        Text(
                            category.time.stringify(),
                            textAlign = TextAlign.Start,
                            fontWeight = FontWeight.Thin
                        )
                    }
                }
            }
        }
    }
}

private fun Time.stringify(): String {
    val minutes = this.toUnit(TimeUnit.MINUTES)
    return String.format("%02d:%02d", minutes / 60, minutes % 60)
}

@Preview
@Composable
fun HomeCategoryViewPreview() {
    HomeCategoryView(category = makeDummyCategories().first())
}
