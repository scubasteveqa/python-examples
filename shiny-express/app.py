from shiny import reactive
from shiny.express import input, render, ui
from shinywidgets import render_plotly

ui.page_opts(title="Penguins dashboard", fillable=True)

with ui.sidebar():
    ui.input_selectize(
        "var", "Select variable",
        ["bill_length_mm", "bill_depth_mm", "flipper_length_mm", "body_mass_g", "year"]
    )
    ui.input_numeric("bins", "Number of bins", 30)

@reactive.calc
def df():
    from palmerpenguins import load_penguins
    return load_penguins()[input.var()]

with ui.card(full_screen=True):
    @render_plotly
    def hist():
        import plotly.express as px
        p = px.histogram(df(), nbins=input.bins())
        p.layout.update(showlegend=False)
        return p
