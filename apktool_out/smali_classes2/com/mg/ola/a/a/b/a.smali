.class public abstract Lcom/mg/ola/a/a/b/a;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Cloneable;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/mg/ola/a/a/b/a$a;
    }
.end annotation


# instance fields
.field a:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/a$a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    return-void
.end method


# virtual methods
.method public abstract a(J)Lcom/mg/ola/a/a/b/a;
.end method

.method public a()V
    .locals 0

    return-void
.end method

.method public abstract a(Landroid/view/animation/Interpolator;)V
.end method

.method public a(Lcom/mg/ola/a/a/b/a$a;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public b()V
    .locals 0

    return-void
.end method

.method public b(Lcom/mg/ola/a/a/b/a$a;)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->remove(Ljava/lang/Object;)Z

    iget-object p1, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    invoke-virtual {p1}, Ljava/util/ArrayList;->size()I

    move-result p1

    if-nez p1, :cond_1

    const/4 p1, 0x0

    iput-object p1, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    :cond_1
    return-void
.end method

.method public c()V
    .locals 0

    return-void
.end method

.method public synthetic clone()Ljava/lang/Object;
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/a;->g()Lcom/mg/ola/a/a/b/a;

    move-result-object v0

    return-object v0
.end method

.method public abstract d()Z
.end method

.method public e()Z
    .locals 1

    invoke-virtual {p0}, Lcom/mg/ola/a/a/b/a;->d()Z

    move-result v0

    return v0
.end method

.method public f()Ljava/util/ArrayList;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/ArrayList<",
            "Lcom/mg/ola/a/a/b/a$a;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    return-object v0
.end method

.method public g()Lcom/mg/ola/a/a/b/a;
    .locals 6

    :try_start_0
    invoke-super {p0}, Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/mg/ola/a/a/b/a;

    iget-object v1, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    if-eqz v1, :cond_0

    iget-object v1, p0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iput-object v2, v0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    invoke-virtual {v1}, Ljava/util/ArrayList;->size()I

    move-result v2

    const/4 v3, 0x0

    :goto_0
    if-ge v3, v2, :cond_0

    iget-object v4, v0, Lcom/mg/ola/a/a/b/a;->a:Ljava/util/ArrayList;

    invoke-virtual {v1, v3}, Ljava/util/ArrayList;->get(I)Ljava/lang/Object;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/CloneNotSupportedException; {:try_start_0 .. :try_end_0} :catch_0

    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    :cond_0
    return-object v0

    :catch_0
    new-instance v0, Ljava/lang/AssertionError;

    invoke-direct {v0}, Ljava/lang/AssertionError;-><init>()V

    throw v0
.end method
