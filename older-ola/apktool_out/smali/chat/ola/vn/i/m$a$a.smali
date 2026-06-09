.class public Lchat/ola/vn/i/m$a$a;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/i/m$a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4
    name = "a"
.end annotation


# instance fields
.field a:Landroid/widget/ImageView;

.field b:Landroid/widget/TextView;

.field final synthetic c:Lchat/ola/vn/i/m$a;


# direct methods
.method public constructor <init>(Lchat/ola/vn/i/m$a;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/i/m$a$a;->c:Lchat/ola/vn/i/m$a;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f090281

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/ImageView;

    iput-object p1, p0, Lchat/ola/vn/i/m$a$a;->a:Landroid/widget/ImageView;

    const p1, 0x7f09052a

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/i/m$a$a;->b:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method
