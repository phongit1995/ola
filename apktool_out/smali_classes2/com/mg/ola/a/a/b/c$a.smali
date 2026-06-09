.class Lcom/mg/ola/a/a/b/c$a;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/mg/ola/a/a/b/a$a;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/a/a/b/c;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "a"
.end annotation


# instance fields
.field final synthetic a:Lcom/mg/ola/a/a/b/c;

.field private b:Lcom/mg/ola/a/a/b/c;


# direct methods
.method constructor <init>(Lcom/mg/ola/a/a/b/c;Lcom/mg/ola/a/a/b/c;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lcom/mg/ola/a/a/b/c$a;->b:Lcom/mg/ola/a/a/b/c;

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/a;)V
    .locals 5

    invoke-virtual {p1, p0}, Lcom/mg/ola/a/a/b/a;->b(Lcom/mg/ola/a/a/b/a$a;)V

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    invoke-static {v0}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    iget-object v0, p0, Lcom/mg/ola/a/a/b/c$a;->b:Lcom/mg/ola/a/a/b/c;

    invoke-static {v0}, Lcom/mg/ola/a/a/b/c;->b(Lcom/mg/ola/a/a/b/c;)Ljava/util/HashMap;

    move-result-object v0

    invoke-virtual {v0, p1}, Ljava/util/HashMap;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/mg/ola/a/a/b/c$e;

    const/4 v0, 0x1

    iput-boolean v0, p1, Lcom/mg/ola/a/a/b/c$e;->f:Z

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    iget-boolean p1, p1, Lcom/mg/ola/a/a/b/c;->b:Z

    if-nez p1, :cond_3

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->b:Lcom/mg/ola/a/a/b/c;

    invoke-static {p1}, Lcom/mg/ola/a/a/b/c;->c(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v1

    const/4 v2, 0x0

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v1, :cond_1

    invoke-virtual {p1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/mg/ola/a/a/b/c$e;

    iget-boolean v4, v4, Lcom/mg/ola/a/a/b/c$e;->f:Z

    if-nez v4, :cond_0

    const/4 v0, 0x0

    goto :goto_1

    :cond_0
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_1
    :goto_1
    if-eqz v0, :cond_3

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    iget-object p1, p1, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    if-eqz p1, :cond_2

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    iget-object p1, p1, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->clone()Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result v0

    const/4 v1, 0x0

    :goto_2
    if-ge v1, v0, :cond_2

    invoke-virtual {p1, v1}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lcom/mg/ola/a/a/b/a$a;

    iget-object v4, p0, Lcom/mg/ola/a/a/b/c$a;->b:Lcom/mg/ola/a/a/b/c;

    invoke-interface {v3, v4}, Lcom/mg/ola/a/a/b/a$a;->a(Lcom/mg/ola/a/a/b/a;)V

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_2
    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->b:Lcom/mg/ola/a/a/b/c;

    invoke-static {p1, v2}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/c;Z)Z

    :cond_3
    return-void
.end method

.method public b(Lcom/mg/ola/a/a/b/a;)V
    .locals 3

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    iget-boolean p1, p1, Lcom/mg/ola/a/a/b/c;->b:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    invoke-static {p1}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;

    move-result-object p1

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    iget-object p1, p1, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    iget-object p1, p1, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, p1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c$a;->a:Lcom/mg/ola/a/a/b/c;

    iget-object v1, v1, Lcom/mg/ola/a/a/b/c;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/a$a;

    iget-object v2, p0, Lcom/mg/ola/a/a/b/c$a;->b:Lcom/mg/ola/a/a/b/c;

    invoke-interface {v1, v2}, Lcom/mg/ola/a/a/b/a$a;->b(Lcom/mg/ola/a/a/b/a;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public c(Lcom/mg/ola/a/a/b/a;)V
    .locals 0

    return-void
.end method

.method public d(Lcom/mg/ola/a/a/b/a;)V
    .locals 0

    return-void
.end method
