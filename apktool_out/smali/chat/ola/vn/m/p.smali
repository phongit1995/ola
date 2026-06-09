.class public abstract Lchat/ola/vn/m/p;
.super Lchat/ola/vn/m/f;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "<T:",
        "Ljava/lang/Object;",
        ">",
        "Lchat/ola/vn/m/f;"
    }
.end annotation


# instance fields
.field private a:Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "TT;"
        }
    .end annotation
.end field

.field protected c:Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/m/f;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract a(Landroid/content/Context;)Ljava/util/ArrayList;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/content/Context;",
            ")",
            "Ljava/util/ArrayList<",
            "Lchat/ola/vn/mediastore/a;",
            ">;"
        }
    .end annotation
.end method

.method public a(Ljava/lang/Object;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(TT;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/m/p;->a:Ljava/lang/Object;

    return-void
.end method

.method public b(Landroid/content/Context;)Lchat/ola/vn/mediastore/a;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public c(Landroid/content/Context;)Lchat/ola/vn/mediastore/a;
    .locals 0

    const/4 p1, 0x0

    return-object p1
.end method

.method public f_()V
    .locals 0

    return-void
.end method

.method public g()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TT;"
        }
    .end annotation

    iget-object v0, p0, Lchat/ola/vn/m/p;->a:Ljava/lang/Object;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/m/p;->a:Ljava/lang/Object;

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public h()V
    .locals 3

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/p;->c:Ljava/util/ArrayList;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/p;->c:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/mediastore/a;

    const/4 v2, 0x0

    invoke-virtual {v1, v2}, Lchat/ola/vn/mediastore/a;->a(Z)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/p;->c:Ljava/util/ArrayList;

    invoke-virtual {v0}, Ljava/util/ArrayList;->clear()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/m/p;->c:Ljava/util/ArrayList;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :catch_0
    move-exception v0

    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-void
.end method

.method public onDetach()V
    .locals 0

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/m/p;->h()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    invoke-super {p0}, Lchat/ola/vn/m/f;->onDetach()V

    return-void
.end method
