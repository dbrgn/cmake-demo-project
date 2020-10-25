#include "mainwindow.h"
#include "./ui_mainwindow.h"
#include <cmark.h>

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->label->setText(ui->label->text() + "<br>" + cmark_markdown_to_html("# Hello cmark", 13, 0));
}

MainWindow::~MainWindow()
{
    delete ui;
}

