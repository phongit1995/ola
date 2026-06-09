.class Lchat/ola/vn/c/m$1;
.super Landroid/util/LruCache;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/c/m;->a(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Landroid/util/LruCache<",
        "Ljava/lang/String;",
        "Lchat/ola/vn/c/a;",
        ">;"
    }
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/c/m;


# direct methods
.method constructor <init>(Lchat/ola/vn/c/m;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/c/m$1;->a:Lchat/ola/vn/c/m;

    invoke-direct {p0, p2}, Landroid/util/LruCache;-><init>(I)V

    return-void
.end method


# virtual methods
.method protected a(Ljava/lang/String;Lchat/ola/vn/c/a;)I
    .locals 0

    iget-object p1, p2, Lchat/ola/vn/c/a;->a:Landroid/graphics/Bitmap;

    invoke-static {p1}, Lchat/ola/vn/util/o;->a(Landroid/graphics/Bitmap;)I

    move-result p1

    return p1
.end method

.method protected a(ZLjava/lang/String;Lchat/ola/vn/c/a;Lchat/ola/vn/c/a;)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-boolean v0, p3, Lchat/ola/vn/c/a;->e:Z

    if-nez v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/c/m$1;->a:Lchat/ola/vn/c/m;

    invoke-virtual {v0, p3}, Lchat/ola/vn/c/m;->a(Lchat/ola/vn/c/a;)V

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/c/m$1;->a:Lchat/ola/vn/c/m;

    invoke-virtual {v0, p3}, Lchat/ola/vn/c/m;->b(Lchat/ola/vn/c/a;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    :goto_0
    invoke-super {p0, p1, p2, p3, p4}, Landroid/util/LruCache;->entryRemoved(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

    return-void
.end method

.method protected synthetic entryRemoved(ZLjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    check-cast p2, Ljava/lang/String;

    check-cast p3, Lchat/ola/vn/c/a;

    check-cast p4, Lchat/ola/vn/c/a;

    invoke-virtual {p0, p1, p2, p3, p4}, Lchat/ola/vn/c/m$1;->a(ZLjava/lang/String;Lchat/ola/vn/c/a;Lchat/ola/vn/c/a;)V

    return-void
.end method

.method protected synthetic sizeOf(Ljava/lang/Object;Ljava/lang/Object;)I
    .locals 0

    check-cast p1, Ljava/lang/String;

    check-cast p2, Lchat/ola/vn/c/a;

    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/c/m$1;->a(Ljava/lang/String;Lchat/ola/vn/c/a;)I

    move-result p1

    return p1
.end method
