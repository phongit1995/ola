.class Lchat/ola/vn/m/w$9;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/p/b;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lchat/ola/vn/m/w;->onItemLongClick(Landroid/widget/AdapterView;Landroid/view/View;IJ)Z
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lchat/ola/vn/m/w;


# direct methods
.method constructor <init>(Lchat/ola/vn/m/w;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/m/w$9;->a:Lchat/ola/vn/m/w;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
    .locals 0

    invoke-virtual {p3}, Lchat/ola/vn/entity/e;->E()I

    move-result p1

    const/4 p2, -0x4

    if-eq p1, p2, :cond_0

    const/16 p2, 0x65

    if-eq p1, p2, :cond_0

    const/4 p1, 0x2

    :goto_0
    invoke-virtual {p3, p1}, Lchat/ola/vn/entity/e;->j(I)V

    return-void

    :cond_0
    const/4 p1, 0x1

    goto :goto_0

    return-void
.end method
