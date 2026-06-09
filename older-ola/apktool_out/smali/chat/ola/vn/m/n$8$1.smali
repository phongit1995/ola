.class Lchat/ola/vn/m/n$8$1;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/n$8;->run()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/List;

.field final synthetic b:Ljava/util/List;

.field final synthetic c:Lchat/ola/vn/m/n$8;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/n$8;Ljava/util/List;Ljava/util/List;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/n$8$1;->c:Lchat/ola/vn/m/n$8;

    iput-object p2, p0, Lchat/ola/vn/m/n$8$1;->a:Ljava/util/List;

    iput-object p3, p0, Lchat/ola/vn/m/n$8$1;->b:Ljava/util/List;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    invoke-virtual {v0}, Lchat/ola/vn/message/g;->m()B

    move-result v0

    const/4 v1, 0x1

    if-ne v0, v1, :cond_2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/m/n$8$1;->c:Lchat/ola/vn/m/n$8;

    iget-object v0, v0, Lchat/ola/vn/m/n$8;->a:Lchat/ola/vn/m/n;

    invoke-virtual {v0}, Lchat/ola/vn/m/n;->g()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lchat/ola/vn/m/e;

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lchat/ola/vn/m/e;->a(Z)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lchat/ola/vn/m/n$8$1;->a:Ljava/util/List;

    if-eqz v0, :cond_0

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/m/n$8$1;->a:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->d(Ljava/util/List;)V

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/m/n$8$1;->b:Ljava/util/List;

    if-eqz v0, :cond_1

    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/m/n$8$1;->b:Ljava/util/List;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->j(Ljava/util/List;)V

    :cond_1
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/g;->a(B)V

    :cond_2
    return-void
.end method
