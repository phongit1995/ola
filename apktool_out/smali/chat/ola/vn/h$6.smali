.class final Lchat/ola/vn/h$6;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/h;->d(Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Ljava/util/List;

.field final synthetic c:Ljava/util/List;


# direct methods
.method constructor <init>(Ljava/util/List;Ljava/util/List;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/h$6;->a:Ljava/util/List;

    iput-object p2, p0, Lchat/ola/vn/h$6;->b:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/h$6;->c:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    invoke-static {}, Lchat/ola/vn/g;->b()V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {v0}, Lchat/ola/vn/r/a/e;->c()I

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_1

    iget-object v0, p0, Lchat/ola/vn/h$6;->a:Ljava/util/List;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/h$6;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget-object v2, p0, Lchat/ola/vn/h$6;->a:Ljava/util/List;

    invoke-virtual {v0, v2}, Lchat/ola/vn/r/a/e;->a(Ljava/util/List;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/h$6;->b:Ljava/util/List;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/h$6;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    if-lez v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    const/4 v2, 0x0

    const/4 v3, 0x0

    iget-object v4, p0, Lchat/ola/vn/h$6;->b:Ljava/util/List;

    invoke-virtual {v0, v2, v3, v4}, Lchat/ola/vn/r/a/e;->a(Ljava/lang/String;SLjava/util/List;)V

    sget-object v0, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    iget-object v2, p0, Lchat/ola/vn/h$6;->b:Ljava/util/List;

    invoke-interface {v2, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/g;

    invoke-virtual {v1}, Lchat/ola/vn/entity/g;->e()J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/r/a/e;->d:J

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/h$6;->c:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->f(Ljava/util/List;)V

    return-void
.end method
