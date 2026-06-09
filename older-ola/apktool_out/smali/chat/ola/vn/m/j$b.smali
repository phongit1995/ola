.class Lchat/ola/vn/m/j$b;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/m/j;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field public a:Lchat/ola/vn/entity/t;

.field public b:J

.field final synthetic c:Lchat/ola/vn/m/j;


# direct methods
.method public constructor <init>(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;J)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/j$b;->c:Lchat/ola/vn/m/j;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p2, p0, Lchat/ola/vn/m/j$b;->a:Lchat/ola/vn/entity/t;

    iput-wide p3, p0, Lchat/ola/vn/m/j$b;->b:J

    return-void
.end method


# virtual methods
.method public run()V
    .locals 7

    sget-object v0, Lchat/ola/vn/m/j;->c:Ljava/util/List;

    iget-object v1, p0, Lchat/ola/vn/m/j$b;->a:Lchat/ola/vn/entity/t;

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    iget-object v0, p0, Lchat/ola/vn/m/j$b;->c:Lchat/ola/vn/m/j;

    invoke-static {v0}, Lchat/ola/vn/m/j;->e(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/j$a;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/m/j$a;->notifyDataSetChanged()V

    iget-object v0, p0, Lchat/ola/vn/m/j$b;->a:Lchat/ola/vn/entity/t;

    iget-wide v1, p0, Lchat/ola/vn/m/j$b;->b:J

    const-wide/16 v3, 0x1

    add-long v5, v1, v3

    invoke-virtual {v0, v5, v6}, Lchat/ola/vn/entity/t;->e(J)V

    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {v0}, Lchat/ola/vn/r/b;->a()Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    iget-object v1, p0, Lchat/ola/vn/m/j$b;->a:Lchat/ola/vn/entity/t;

    invoke-virtual {v0, v1}, Lchat/ola/vn/r/b;->b(Lchat/ola/vn/entity/t;)V

    sget-object v0, Lchat/ola/vn/h;->s:Lchat/ola/vn/r/b;

    invoke-virtual {v0}, Lchat/ola/vn/r/b;->i()V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/j$b;->c:Lchat/ola/vn/m/j;

    invoke-static {v0}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/c;

    move-result-object v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/m/j$b;->c:Lchat/ola/vn/m/j;

    invoke-static {v0}, Lchat/ola/vn/m/j;->c(Lchat/ola/vn/m/j;)Lchat/ola/vn/m/c;

    move-result-object v0

    invoke-virtual {v0}, Lchat/ola/vn/m/c;->h()V

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/m/j$b;->c:Lchat/ola/vn/m/j;

    invoke-virtual {v0}, Lchat/ola/vn/m/j;->e()V

    iget-object v0, p0, Lchat/ola/vn/m/j$b;->c:Lchat/ola/vn/m/j;

    iget-object v1, p0, Lchat/ola/vn/m/j$b;->a:Lchat/ola/vn/entity/t;

    invoke-static {v0, v1}, Lchat/ola/vn/m/j;->a(Lchat/ola/vn/m/j;Lchat/ola/vn/entity/t;)V

    return-void
.end method
