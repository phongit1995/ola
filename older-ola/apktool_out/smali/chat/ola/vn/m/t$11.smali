.class Lchat/ola/vn/m/t$11;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/t;->a(JJ)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:J

.field final synthetic b:Lchat/ola/vn/m/t;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/t;J)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    iput-wide p2, p0, Lchat/ola/vn/m/t$11;->a:J

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

    iget-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    const/4 p2, 0x0

    invoke-static {p1, p2}, Lchat/ola/vn/m/t;->a(Lchat/ola/vn/m/t;Z)Z

    iget-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    iget-object p1, p1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/e;->d(Z)V

    iget-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    iget-object p1, p1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, p2}, Lchat/ola/vn/entity/e;->b(Z)V

    iget-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    invoke-virtual {p1}, Lchat/ola/vn/m/t;->v()V

    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 6

    const/4 v0, 0x1

    aget-object p1, p1, v0

    check-cast p1, Ljava/util/List;

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    invoke-interface {p1}, Ljava/util/List;->isEmpty()Z

    move-result v1

    if-nez v1, :cond_1

    invoke-static {p1}, Lchat/ola/vn/r/a/e;->b(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    iget-wide v1, p0, Lchat/ola/vn/m/t$11;->a:J

    const-wide/16 v3, 0x0

    cmp-long v5, v1, v3

    if-nez v5, :cond_0

    iget-object v1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    iget-object v1, v1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1, p1}, Lchat/ola/vn/entity/e;->a(Ljava/util/List;)V

    goto :goto_0

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    invoke-virtual {v1}, Lchat/ola/vn/m/t;->c()V

    iget-object v1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    iget-object v1, v1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {v1, p1}, Lchat/ola/vn/entity/e;->b(Ljava/util/List;)V

    goto :goto_0

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    invoke-static {p1, v0}, Lchat/ola/vn/m/t;->a(Lchat/ola/vn/m/t;Z)Z

    iget-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    iget-object p1, p1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->d(Z)V

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    iget-object p1, p1, Lchat/ola/vn/m/t;->a:Lchat/ola/vn/entity/e;

    invoke-virtual {p1, v0}, Lchat/ola/vn/entity/e;->b(Z)V

    iget-object p1, p0, Lchat/ola/vn/m/t$11;->b:Lchat/ola/vn/m/t;

    invoke-virtual {p1}, Lchat/ola/vn/m/t;->v()V

    return-void
.end method
