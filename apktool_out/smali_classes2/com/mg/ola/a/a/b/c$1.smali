.class Lcom/mg/ola/a/a/b/c$1;
.super Lcom/mg/ola/a/a/b/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/mg/ola/a/a/b/c;->a()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field a:Z

.field final synthetic b:Ljava/util/ArrayList;

.field final synthetic c:Lcom/mg/ola/a/a/b/c;


# direct methods
.method constructor <init>(Lcom/mg/ola/a/a/b/c;Ljava/util/ArrayList;)V
    .locals 0

    iput-object p1, p0, Lcom/mg/ola/a/a/b/c$1;->c:Lcom/mg/ola/a/a/b/c;

    iput-object p2, p0, Lcom/mg/ola/a/a/b/c$1;->b:Ljava/util/ArrayList;

    invoke-direct {p0}, Lcom/mg/ola/a/a/b/b;-><init>()V

    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/c$1;->a:Z

    return-void
.end method


# virtual methods
.method public a(Lcom/mg/ola/a/a/b/a;)V
    .locals 3

    iget-boolean p1, p0, Lcom/mg/ola/a/a/b/c$1;->a:Z

    if-nez p1, :cond_0

    iget-object p1, p0, Lcom/mg/ola/a/a/b/c$1;->b:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    const/4 v0, 0x0

    :goto_0
    if-ge v0, p1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/c$1;->b:Ljava/util/ArrayList;

    invoke-virtual {v1, v0}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/mg/ola/a/a/b/c$e;

    iget-object v2, v1, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v2}, Lcom/mg/ola/a/a/b/a;->a()V

    iget-object v2, p0, Lcom/mg/ola/a/a/b/c$1;->c:Lcom/mg/ola/a/a/b/c;

    invoke-static {v2}, Lcom/mg/ola/a/a/b/c;->a(Lcom/mg/ola/a/a/b/c;)Ljava/util/ArrayList;

    move-result-object v2

    iget-object v1, v1, Lcom/mg/ola/a/a/b/c$e;->a:Lcom/mg/ola/a/a/b/a;

    invoke-virtual {v2, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method

.method public b(Lcom/mg/ola/a/a/b/a;)V
    .locals 0

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/mg/ola/a/a/b/c$1;->a:Z

    return-void
.end method
