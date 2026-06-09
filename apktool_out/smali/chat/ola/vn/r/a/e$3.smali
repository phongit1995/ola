.class final Lchat/ola/vn/r/a/e$3;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/r/a/e;->f(Ljava/util/List;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;


# direct methods
.method constructor <init>(Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/r/a/e$3;->a:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 4

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/r/a/e$3;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/q;

    invoke-static {}, Lchat/ola/vn/r/a/e;->A()Ljava/util/Map;

    move-result-object v2

    iget-object v3, v1, Lchat/ola/vn/entity/q;->c:Ljava/lang/String;

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/g;

    if-eqz v2, :cond_0

    iget v3, v1, Lchat/ola/vn/entity/q;->d:I

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/g;->a(I)V

    iget v3, v1, Lchat/ola/vn/entity/q;->e:I

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/g;->c(I)V

    iget-short v3, v1, Lchat/ola/vn/entity/q;->f:S

    invoke-virtual {v2, v3}, Lchat/ola/vn/entity/g;->c(S)V

    iget-object v1, v1, Lchat/ola/vn/entity/q;->a:[Ljava/lang/String;

    invoke-virtual {v2, v1}, Lchat/ola/vn/entity/g;->a([Ljava/lang/String;)V

    goto :goto_0

    :cond_1
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/c;->j()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
