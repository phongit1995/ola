.class Lcom/mg/ola/common/c/b$2;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/View$OnClickListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/c/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/common/c/b;


# direct methods
.method constructor <init>(Lcom/mg/ola/common/c/b;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/common/c/b$2;->a:Lcom/mg/ola/common/c/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onClick(Landroid/view/View;)V
    .locals 4

    iget-object v0, p0, Lcom/mg/ola/common/c/b$2;->a:Lcom/mg/ola/common/c/b;

    invoke-virtual {v0}, Lcom/mg/ola/common/c/b;->h()Lcom/mg/ola/common/c/c$a;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/mg/ola/common/c/b$2;->a:Lcom/mg/ola/common/c/b;

    invoke-static {v1}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/b;)Ljava/util/List;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    iget-object v3, p0, Lcom/mg/ola/common/c/b$2;->a:Lcom/mg/ola/common/c/b;

    invoke-static {v3}, Lcom/mg/ola/common/c/b;->a(Lcom/mg/ola/common/c/b;)Ljava/util/List;

    move-result-object v3

    invoke-interface {v3, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/common/c/a;

    iget-object v3, v3, Lcom/mg/ola/common/c/a;->d:Ljava/lang/ref/WeakReference;

    invoke-virtual {v3}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v3

    if-ne p1, v3, :cond_0

    iget-object p1, p0, Lcom/mg/ola/common/c/b$2;->a:Lcom/mg/ola/common/c/b;

    invoke-interface {v0, p1, v2}, Lcom/mg/ola/common/c/c$a;->a(Lcom/mg/ola/common/c/c;I)V

    goto :goto_1

    :cond_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    iget-object p1, p0, Lcom/mg/ola/common/c/b$2;->a:Lcom/mg/ola/common/c/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/c/b;->e()Z

    move-result p1

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/mg/ola/common/c/b$2;->a:Lcom/mg/ola/common/c/b;

    invoke-virtual {p1}, Lcom/mg/ola/common/c/b;->getContentView()Landroid/view/View;

    move-result-object p1

    new-instance v0, Lcom/mg/ola/common/c/b$2$1;

    invoke-direct {v0, p0}, Lcom/mg/ola/common/c/b$2$1;-><init>(Lcom/mg/ola/common/c/b$2;)V

    const-wide/16 v1, 0x64

    invoke-virtual {p1, v0, v1, v2}, Landroid/view/View;->postDelayed(Ljava/lang/Runnable;J)Z

    :cond_2
    return-void
.end method
