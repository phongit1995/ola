.class Lchat/ola/vn/me/a$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/u/o;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/me/a;->b()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/entity/ab;

.field final synthetic b:Lchat/ola/vn/me/a;


# direct methods
.method constructor <init>(Lchat/ola/vn/me/a;Lchat/ola/vn/entity/ab;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    iput-object p2, p0, Lchat/ola/vn/me/a$1;->a:Lchat/ola/vn/entity/ab;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a()V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {v0}, Lchat/ola/vn/me/a;->g(Lchat/ola/vn/me/a;)I

    :try_start_0
    invoke-static {}, Lchat/ola/vn/c;->c()Lchat/ola/vn/c;

    move-result-object v0

    const v1, 0x7f0f0385

    invoke-static {v0, v1}, Lchat/ola/vn/util/j;->d(Landroid/content/Context;I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method


# virtual methods
.method public a(II)V
    .locals 8

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    int-to-long v1, p1

    int-to-long v3, p2

    iget-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {p1}, Lchat/ola/vn/me/a;->b(Lchat/ola/vn/me/a;)I

    move-result v5

    iget-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {p1}, Lchat/ola/vn/me/a;->c(Lchat/ola/vn/me/a;)I

    move-result v6

    iget-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {p1}, Lchat/ola/vn/me/a;->d(Lchat/ola/vn/me/a;)I

    move-result v7

    invoke-static/range {v0 .. v7}, Lchat/ola/vn/util/c/b;->a(Landroid/content/Context;JJIII)V

    return-void
.end method

.method public a(Lchat/ola/vn/entity/i;)V
    .locals 2

    iget-object v0, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {v0}, Lchat/ola/vn/me/a;->a(Lchat/ola/vn/me/a;)I

    iget-object v0, p0, Lchat/ola/vn/me/a$1;->a:Lchat/ola/vn/entity/ab;

    const/4 v1, 0x0

    iput-byte v1, v0, Lchat/ola/vn/entity/ab;->b:B

    iget-object v0, p0, Lchat/ola/vn/me/a$1;->a:Lchat/ola/vn/entity/ab;

    invoke-virtual {p1}, Lchat/ola/vn/entity/i;->d()Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    iget-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {p1}, Lchat/ola/vn/me/a;->b(Lchat/ola/vn/me/a;)I

    move-result p1

    if-lez p1, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {p1}, Lchat/ola/vn/me/a;->c(Lchat/ola/vn/me/a;)I

    move-result p1

    iget-object v0, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {v0}, Lchat/ola/vn/me/a;->b(Lchat/ola/vn/me/a;)I

    move-result v0

    add-int/2addr p1, v0

    iget-object v0, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {v0}, Lchat/ola/vn/me/a;->d(Lchat/ola/vn/me/a;)I

    move-result v0

    if-ne p1, v0, :cond_0

    iget-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {p1}, Lchat/ola/vn/me/a;->e(Lchat/ola/vn/me/a;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {p1}, Lchat/ola/vn/me/a;->c(Lchat/ola/vn/me/a;)I

    move-result p1

    iget-object v0, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {v0}, Lchat/ola/vn/me/a;->d(Lchat/ola/vn/me/a;)I

    move-result v0

    if-ne p1, v0, :cond_1

    iget-object p1, p0, Lchat/ola/vn/me/a$1;->b:Lchat/ola/vn/me/a;

    invoke-static {p1}, Lchat/ola/vn/me/a;->f(Lchat/ola/vn/me/a;)V

    :cond_1
    return-void
.end method

.method public a(Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/a$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;I)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/a$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/a$1;->a()V

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/a$1;->a()V

    return-void
.end method

.method public b(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/a$1;->a()V

    return-void
.end method
