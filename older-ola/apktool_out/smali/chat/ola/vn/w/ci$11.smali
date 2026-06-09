.class Lchat/ola/vn/w/ci$11;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/w/ci;->b(I)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:I

.field final synthetic b:Lchat/ola/vn/w/ci;


# direct methods
.method constructor <init>(Lchat/ola/vn/w/ci;I)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/w/ci$11;->b:Lchat/ola/vn/w/ci;

    iput p2, p0, Lchat/ola/vn/w/ci$11;->a:I

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    new-instance v0, Lchat/ola/vn/w/bk;

    const/16 v1, 0xa4

    invoke-direct {v0, v1}, Lchat/ola/vn/w/bk;-><init>(S)V

    iget v1, p0, Lchat/ola/vn/w/ci$11;->a:I

    iput v1, v0, Lchat/ola/vn/w/bk;->aa:I

    iget-object v1, p0, Lchat/ola/vn/w/ci$11;->b:Lchat/ola/vn/w/ci;

    invoke-static {v1, v0}, Lchat/ola/vn/w/ci;->a(Lchat/ola/vn/w/ci;Lchat/ola/vn/w/bk;)V

    return-void
.end method
