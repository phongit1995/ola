.class Lchat/ola/vn/m/y$2;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/y;->A()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/t;

.field final synthetic b:Lchat/ola/vn/m/y;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/y;Lchat/ola/vn/entity/t;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/y$2;->b:Lchat/ola/vn/m/y;

    iput-object p2, p0, Lchat/ola/vn/m/y$2;->a:Lchat/ola/vn/entity/t;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/4 v0, 0x6

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    const/16 p2, 0x22

    if-ne p2, p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/m/y$2;->a:Lchat/ola/vn/entity/t;

    const/4 p2, 0x0

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/t;->b(Z)V

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/m/y$2;->a:Lchat/ola/vn/entity/t;

    const-wide/16 p2, -0x1

    invoke-virtual {p1, p2, p3}, Lchat/ola/vn/entity/t;->b(J)V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    aget-object v0, p1, v0

    check-cast v0, Lchat/ola/vn/entity/g;

    const/4 v1, 0x1

    aget-object p1, p1, v1

    check-cast p1, Ljava/util/List;

    iget-object v2, p0, Lchat/ola/vn/m/y$2;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2}, Lchat/ola/vn/entity/t;->a()J

    move-result-wide v2

    const-wide/16 v4, 0x0

    cmp-long v6, v2, v4

    if-lez v6, :cond_0

    iget-object v2, p0, Lchat/ola/vn/m/y$2;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v0, p1}, Lchat/ola/vn/entity/t;->b(Lchat/ola/vn/entity/g;Ljava/util/List;)Z

    goto :goto_0

    :cond_0
    iget-object v2, p0, Lchat/ola/vn/m/y$2;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v2, v0, p1}, Lchat/ola/vn/entity/t;->a(Lchat/ola/vn/entity/g;Ljava/util/List;)Z

    :goto_0
    iget-object v0, p0, Lchat/ola/vn/m/y$2;->a:Lchat/ola/vn/entity/t;

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result p1

    xor-int/2addr p1, v1

    invoke-virtual {v0, p1}, Lchat/ola/vn/entity/t;->b(Z)V

    iget-object p1, p0, Lchat/ola/vn/m/y$2;->a:Lchat/ola/vn/entity/t;

    const-wide/16 v0, -0x1

    invoke-virtual {p1, v0, v1}, Lchat/ola/vn/entity/t;->b(J)V

    iget-object p1, p0, Lchat/ola/vn/m/y$2;->b:Lchat/ola/vn/m/y;

    invoke-static {p1}, Lchat/ola/vn/m/y;->c(Lchat/ola/vn/m/y;)Lchat/ola/vn/b/ah;

    move-result-object p1

    invoke-virtual {p1}, Lchat/ola/vn/b/ah;->notifyDataSetChanged()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
