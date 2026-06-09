.class final Lchat/ola/vn/util/b/b$1;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/util/b/a;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/util/b/b;->a(Landroid/content/Context;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Lchat/ola/vn/util/b/c;

.field private c:Lchat/ola/vn/i/l;


# direct methods
.method constructor <init>(Landroid/content/Context;Lchat/ola/vn/util/b/c;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/util/b/b$1;->a:Landroid/content/Context;

    iput-object p2, p0, Lchat/ola/vn/util/b/b$1;->b:Lchat/ola/vn/util/b/c;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/util/b/b$1;)Lchat/ola/vn/i/l;
    .locals 0

    iget-object p0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    return-object p0
.end method


# virtual methods
.method public a()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    invoke-virtual {v0}, Lchat/ola/vn/i/l;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(JJ)V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    invoke-virtual {v0, p3, p4}, Lchat/ola/vn/i/l;->b(J)V

    iget-object p3, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    invoke-virtual {p3, p1, p2}, Lchat/ola/vn/i/l;->a(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    invoke-virtual {p1}, Lchat/ola/vn/i/l;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public b()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    invoke-virtual {v0}, Lchat/ola/vn/i/l;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c()V
    .locals 2

    new-instance v0, Lchat/ola/vn/i/l;

    iget-object v1, p0, Lchat/ola/vn/util/b/b$1;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Lchat/ola/vn/i/l;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    const v1, 0x7f0f033e

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/l;->b(I)V

    iget-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    const v1, 0x7f0f044d

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/l;->a(I)V

    iget-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    new-instance v1, Lchat/ola/vn/util/b/b$1$1;

    invoke-direct {v1, p0}, Lchat/ola/vn/util/b/b$1$1;-><init>(Lchat/ola/vn/util/b/b$1;)V

    invoke-virtual {v0, v1}, Lchat/ola/vn/i/l;->a(Landroid/content/DialogInterface$OnClickListener;)V

    iget-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    invoke-virtual {v0}, Lchat/ola/vn/i/l;->show()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public d()V
    .locals 1

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/util/b/b$1;->c:Lchat/ola/vn/i/l;

    invoke-virtual {v0}, Lchat/ola/vn/i/l;->dismiss()V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
