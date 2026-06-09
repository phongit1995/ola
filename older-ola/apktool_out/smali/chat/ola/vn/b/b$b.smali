.class Lchat/ola/vn/b/b$b;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lchat/ola/vn/b/b;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "b"
.end annotation


# instance fields
.field a:Landroid/widget/TextView;

.field final synthetic b:Lchat/ola/vn/b/b;


# direct methods
.method public constructor <init>(Lchat/ola/vn/b/b;Landroid/view/View;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/b/b$b;->b:Lchat/ola/vn/b/b;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const p1, 0x7f0904fe

    invoke-virtual {p2, p1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object p1

    check-cast p1, Landroid/widget/TextView;

    iput-object p1, p0, Lchat/ola/vn/b/b$b;->a:Landroid/widget/TextView;

    invoke-virtual {p2, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    return-void
.end method
