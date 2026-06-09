.class Lcom/mg/ola/a/a/c/f$a;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/mg/ola/a/a/b/a$a;
.implements Lcom/mg/ola/a/a/b/n$b;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/c/f;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/a/a/c/f;


# direct methods
.method private constructor <init>(Lcom/mg/ola/a/a/c/f;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lcom/mg/ola/a/a/c/f;Lcom/mg/ola/a/a/c/f$1;)V
    .locals 0

    invoke-direct {p0, p1}, Lcom/mg/ola/a/a/c/f$a;-><init>(Lcom/mg/ola/a/a/c/f;)V

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/a;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/mg/ola/a/a/b/a$a;->a(Lcom/mg/ola/a/a/b/a;)V

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->c(Lcom/mg/ola/a/a/c/f;)Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->remove(Ljava/lang/Object;)Ljava/lang/Object;

    iget-object p1, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {p1}, Lcom/mg/ola/a/a/c/f;->c(Lcom/mg/ola/a/a/c/f;)Ljava/util/HashMap;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/HashMap;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_1

    iget-object p1, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    const/4 v0, 0x0

    invoke-static {p1, v0}, Lcom/mg/ola/a/a/c/f;->a(Lcom/mg/ola/a/a/c/f;Lcom/mg/ola/a/a/b/a$a;)Lcom/mg/ola/a/a/b/a$a;

    :cond_1
    return-void
.end method

.method public a(Lcom/mg/ola/a/a/b/n;)V
    .locals 6

    invoke-virtual {p1}, Lcom/mg/ola/a/a/b/n;->m()F

    move-result v0

    iget-object v1, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v1}, Lcom/mg/ola/a/a/c/f;->c(Lcom/mg/ola/a/a/c/f;)Ljava/util/HashMap;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/a/a/c/f$c;

    iget v1, p1, Lcom/mg/ola/a/a/c/f$c;->a:I

    and-int/lit16 v1, v1, 0x1ff

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v1}, Lcom/mg/ola/a/a/c/f;->d(Lcom/mg/ola/a/a/c/f;)Ljava/lang/ref/WeakReference;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/view/View;

    if-eqz v1, :cond_0

    invoke-virtual {v1}, Landroid/view/View;->invalidate()V

    :cond_0
    iget-object p1, p1, Lcom/mg/ola/a/a/c/f$c;->b:Ljava/util/ArrayList;

    if-eqz p1, :cond_1

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_1

    invoke-virtual {p1, v2}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/c/f$b;

    iget v4, v3, Lcom/mg/ola/a/a/c/f$b;->b:F

    iget v5, v3, Lcom/mg/ola/a/a/c/f$b;->c:F

    mul-float v5, v5, v0

    add-float/2addr v4, v5

    iget-object v5, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    iget v3, v3, Lcom/mg/ola/a/a/c/f$b;->a:I

    invoke-static {v5, v3, v4}, Lcom/mg/ola/a/a/c/f;->a(Lcom/mg/ola/a/a/c/f;IF)V

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {p1}, Lcom/mg/ola/a/a/c/f;->d(Lcom/mg/ola/a/a/c/f;)Ljava/lang/ref/WeakReference;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/ref/WeakReference;->get()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Landroid/view/View;

    if-eqz p1, :cond_2

    invoke-virtual {p1}, Landroid/view/View;->invalidate()V

    :cond_2
    return-void
.end method

.method public b(Lcom/mg/ola/a/a/b/a;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/mg/ola/a/a/b/a$a;->b(Lcom/mg/ola/a/a/b/a;)V

    :cond_0
    return-void
.end method

.method public c(Lcom/mg/ola/a/a/b/a;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/mg/ola/a/a/b/a$a;->c(Lcom/mg/ola/a/a/b/a;)V

    :cond_0
    return-void
.end method

.method public d(Lcom/mg/ola/a/a/b/a;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/mg/ola/a/a/c/f$a;->a:Lcom/mg/ola/a/a/c/f;

    invoke-static {v0}, Lcom/mg/ola/a/a/c/f;->b(Lcom/mg/ola/a/a/c/f;)Lcom/mg/ola/a/a/b/a$a;

    move-result-object v0

    invoke-interface {v0, p1}, Lcom/mg/ola/a/a/b/a$a;->d(Lcom/mg/ola/a/a/b/a;)V

    :cond_0
    return-void
.end method
