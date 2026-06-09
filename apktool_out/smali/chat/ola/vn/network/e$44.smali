.class Lchat/ola/vn/network/e$44;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/c/g;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/network/e;->a(Lchat/ola/vn/w/ci;S)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/network/e;


# direct methods
.method constructor <init>(Lchat/ola/vn/network/e;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/e$44;->a:Lchat/ola/vn/network/e;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lchat/ola/vn/c/f;)V
    .locals 1

    invoke-virtual {p1}, Lchat/ola/vn/c/f;->c()Landroid/graphics/Bitmap;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/badger/e;->a(Landroid/graphics/Bitmap;)[B

    move-result-object p1

    invoke-static {}, Lchat/ola/vn/h;->a()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0, p1}, Lchat/ola/vn/h/b;->b(Ljava/lang/String;[B)V

    return-void
.end method

.method public b(Lchat/ola/vn/c/f;)V
    .locals 0

    return-void
.end method
