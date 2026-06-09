.class Lchat/ola/vn/network/e$42;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Ljava/lang/String;SLjava/lang/String;Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/String;

.field final synthetic b:S

.field final synthetic c:Ljava/lang/String;

.field final synthetic d:Z

.field final synthetic e:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;Ljava/lang/String;SLjava/lang/String;Z)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$42;->e:Lchat/ola/vn/network/e;

    iput-object p2, p0, Lchat/ola/vn/network/e$42;->a:Ljava/lang/String;

    iput-short p3, p0, Lchat/ola/vn/network/e$42;->b:S

    iput-object p4, p0, Lchat/ola/vn/network/e$42;->c:Ljava/lang/String;

    iput-boolean p5, p0, Lchat/ola/vn/network/e$42;->d:Z

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 3

    :try_start_0
    sget-object v0, Lchat/ola/vn/h;->t:Lchat/ola/vn/message/g;

    iget-object v1, p0, Lchat/ola/vn/network/e$42;->a:Ljava/lang/String;

    iget-short v2, p0, Lchat/ola/vn/network/e$42;->b:S

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/message/g;->d(Ljava/lang/String;S)Lchat/ola/vn/message/f;

    move-result-object v0

    if-eqz v0, :cond_0

    iget-object v1, p0, Lchat/ola/vn/network/e$42;->c:Ljava/lang/String;

    invoke-virtual {v0, v1}, Lchat/ola/vn/message/f;->o(Ljava/lang/String;)Lchat/ola/vn/message/d;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-boolean v2, p0, Lchat/ola/vn/network/e$42;->d:Z

    iput-boolean v2, v1, Lchat/ola/vn/message/d;->x:Z

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->E()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_0
    return-void
.end method
