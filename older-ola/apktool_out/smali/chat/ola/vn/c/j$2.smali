.class Lchat/ola/vn/c/j$2;
.super Landroid/support/v4/util/LruCache;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/j;->b(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/support/v4/util/LruCache<",
        "Ljava/lang/String;",
        "Lchat/ola/vn/c/a;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/j;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/j;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/j$2;->a:Lchat/ola/vn/c/j;

    invoke-direct {p0, p2}, Landroid/support/v4/util/LruCache;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected a(ZLjava/lang/String;Lchat/ola/vn/c/a;Lchat/ola/vn/c/a;)V
    .locals 0

    if-eqz p1, :cond_0

    :try_start_0
    iget-boolean p1, p3, Lchat/ola/vn/c/a;->e:Z

    if-nez p1, :cond_1

    :goto_0
    iget-object p1, p0, Lchat/ola/vn/c/j$2;->a:Lchat/ola/vn/c/j;

    invoke-virtual {p1, p3}, Lchat/ola/vn/c/j;->a(Lchat/ola/vn/c/a;)V

    return-void

    :cond_0
    if-eqz p4, :cond_1

    iget-object p1, p3, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    invoke-static {p1}, Lchat/ola/vn/util/o;->a(Landroid/graphics/Bitmap;)I

    move-result p1

    iget-object p2, p4, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    invoke-static {p2}, Lchat/ola/vn/util/o;->a(Landroid/graphics/Bitmap;)I

    move-result p2

    if-lt p1, p2, :cond_1

    iget-boolean p1, p3, Lchat/ola/vn/c/a;->e:Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    if-nez p1, :cond_1

    goto :goto_0

    :catch_0
    :cond_1
    return-void
.end method

.method protected synthetic entryRemoved(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    check-cast p2, Ljava/lang/String;

    check-cast p3, Lchat/ola/vn/c/a;

    check-cast p4, Lchat/ola/vn/c/a;

    invoke-virtual {p0, p1, p2, p3, p4}, Lchat/ola/vn/c/j$2;->a(ZLjava/lang/String;Lchat/ola/vn/c/a;Lchat/ola/vn/c/a;)V

    return-void
.end method
