.class Lchat/ola/vn/me/a$2;
.super Lchat/ola/vn/entry/c/e;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/a;->c()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/me/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/a;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/a$2;->a:Lchat/ola/vn/me/a;

    invoke-direct {p0}, Lchat/ola/vn/entry/c/e;-><init>()V

    return-void
.end method


# virtual methods
.method public a()S
    .locals 1

    const/4 v0, 0x1

    return v0
.end method

.method public a(ISLjava/lang/String;[Lchat/ola/vn/entity/d;)V
    .locals 0

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1, p3}, Lchat/ola/vn/util/c/c;->a(Landroid/content/Context;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public varargs a([Ljava/lang/Object;)V
    .locals 1

    :try_start_0
    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/c/c;->b(Landroid/content/Context;)V

    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    invoke-virtual {p1}, Lchat/ola/vn/r/a/e;->y()Lchat/ola/vn/me/a;

    move-result-object p1

    if-eqz p1, :cond_0

    iget-object v0, p0, Lchat/ola/vn/me/a$2;->a:Lchat/ola/vn/me/a;

    invoke-virtual {p1, v0}, Lchat/ola/vn/me/a;->equals(Ljava/lang/Object;)Z

    move-result p1

    if-eqz p1, :cond_1

    :cond_0
    sget-object p1, Lchat/ola/vn/h;->u:Lchat/ola/vn/r/a/e;

    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Lchat/ola/vn/r/a/e;->a(Lchat/ola/vn/me/a;)V

    :cond_1
    iget-object p1, p0, Lchat/ola/vn/me/a$2;->a:Lchat/ola/vn/me/a;

    iget-object p1, p1, Lchat/ola/vn/me/a;->d:Ljava/lang/String;

    if-eqz p1, :cond_2

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object p1

    iget-object v0, p0, Lchat/ola/vn/me/a$2;->a:Lchat/ola/vn/me/a;

    iget-object v0, v0, Lchat/ola/vn/me/a;->d:Ljava/lang/String;

    invoke-virtual {p1, v0}, Lchat/ola/vn/n/c;->a(Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_2
    return-void
.end method
