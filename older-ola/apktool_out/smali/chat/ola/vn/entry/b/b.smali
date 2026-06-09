.class public abstract Lchat/ola/vn/entry/b/b;
.super Ljava/lang/Object;


# instance fields
.field protected a:Landroid/view/View$OnClickListener;

.field protected b:Landroid/view/View$OnLongClickListener;

.field protected c:Z

.field protected d:Landroid/view/View;

.field protected e:I


# direct methods
.method public constructor <init>(Landroid/view/View;)V
    .locals 1

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x1

    iput-boolean v0, p0, Lchat/ola/vn/entry/b/b;->c:Z

    const/4 v0, -0x1

    iput v0, p0, Lchat/ola/vn/entry/b/b;->e:I

    if-eqz p1, :cond_0

    iput-object p1, p0, Lchat/ola/vn/entry/b/b;->d:Landroid/view/View;

    invoke-virtual {p1, p0}, Landroid/view/View;->setTag(Ljava/lang/Object;)V

    :cond_0
    return-void
.end method


# virtual methods
.method public a()V
    .locals 0

    return-void
.end method

.method public a(Landroid/view/View$OnClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/b;->a:Landroid/view/View$OnClickListener;

    return-void
.end method

.method public a(Landroid/view/View$OnLongClickListener;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/entry/b/b;->b:Landroid/view/View$OnLongClickListener;

    return-void
.end method

.method public abstract a(Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;Lchat/ola/vn/message/d;)V
.end method

.method public b()Landroid/view/View;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/entry/b/b;->d:Landroid/view/View;

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 0

    const/4 p1, 0x0

    return p1
.end method
