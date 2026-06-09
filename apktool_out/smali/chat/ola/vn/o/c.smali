.class public Lchat/ola/vn/o/c;
.super Lchat/ola/vn/entry/e;


# instance fields
.field protected m:Lchat/ola/vn/entity/d;


# direct methods
.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;)V
    .locals 1

    const v0, 0x7f0f00fd

    invoke-direct {p0, v0, p1, p2}, Lchat/ola/vn/entry/e;-><init>(ILjava/lang/String;Ljava/lang/String;)V

    const/4 p1, 0x0

    iput-object p1, p0, Lchat/ola/vn/o/c;->m:Lchat/ola/vn/entity/d;

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/entity/d;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/o/c;->m:Lchat/ola/vn/entity/d;

    return-void
.end method

.method public b(Landroid/content/Context;)Z
    .locals 2

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/o/c;->m:Lchat/ola/vn/entity/d;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lchat/ola/vn/o/c;->m:Lchat/ola/vn/entity/d;

    invoke-virtual {v0, p1}, Lchat/ola/vn/entity/d;->a(Landroid/content/Context;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p0}, Lchat/ola/vn/o/c;->g()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    invoke-virtual {p0}, Lchat/ola/vn/o/c;->g()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p0}, Lchat/ola/vn/o/c;->f()Ljava/lang/String;

    move-result-object v1

    invoke-static {p1, v0, v1}, Lchat/ola/vn/m/m;->a(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_1
    :goto_0
    const/4 p1, 0x1

    return p1

    :catch_0
    const/4 p1, 0x0

    return p1
.end method
