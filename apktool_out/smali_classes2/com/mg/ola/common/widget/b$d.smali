.class Lcom/mg/ola/common/widget/b$d;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/widget/AbsListView$OnScrollListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "d"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/widget/b;


# direct methods
.method private constructor <init>(Lcom/mg/ola/common/widget/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/widget/b$d;->a:Lcom/mg/ola/common/widget/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/common/widget/b;Lcom/mg/ola/common/widget/b$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/common/widget/b$d;-><init>(Lcom/mg/ola/common/widget/b;)V

    return-void
.end method


# virtual methods
.method public onScroll(Landroid/widget/AbsListView;III)V
    .locals 0

    return-void
.end method

.method public onScrollStateChanged(Landroid/widget/AbsListView;I)V
    .locals 0

    const/4 p1, 0x1

    if-ne p2, p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b$d;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->g(Lcom/mg/ola/common/widget/b;)Z

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b$d;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->d(Lcom/mg/ola/common/widget/b;)Landroid/widget/PopupWindow;

    move-result-object p1

    invoke-virtual {p1}, Landroid/widget/PopupWindow;->getContentView()Landroid/view/View;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/widget/b$d;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->f(Lcom/mg/ola/common/widget/b;)Landroid/os/Handler;

    move-result-object p1

    iget-object p2, p0, Lcom/mg/ola/common/widget/b$d;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p2}, Lcom/mg/ola/common/widget/b;->e(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$f;

    move-result-object p2

    invoke-virtual {p1, p2}, Landroid/os/Handler;->removeCallbacks(Ljava/lang/Runnable;)V

    iget-object p1, p0, Lcom/mg/ola/common/widget/b$d;->a:Lcom/mg/ola/common/widget/b;

    invoke-static {p1}, Lcom/mg/ola/common/widget/b;->e(Lcom/mg/ola/common/widget/b;)Lcom/mg/ola/common/widget/b$f;

    move-result-object p1

    invoke-virtual {p1}, Lcom/mg/ola/common/widget/b$f;->run()V

    :cond_0
    return-void
.end method
