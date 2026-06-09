.class public Lchat/ola/vn/b/b;
.super Landroid/widget/BaseExpandableListAdapter;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lchat/ola/vn/b/b$a;,
        Lchat/ola/vn/b/b$b;
    }
.end annotation


# instance fields
.field private a:Landroid/view/LayoutInflater;

.field private b:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/a/b;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    invoke-direct {p0}, Landroid/widget/BaseExpandableListAdapter;-><init>()V

    invoke-static {p1}, Landroid/view/LayoutInflater;->from(Landroid/content/Context;)Landroid/view/LayoutInflater;

    move-result-object p1

    iput-object p1, p0, Lchat/ola/vn/b/b;->a:Landroid/view/LayoutInflater;

    return-void
.end method


# virtual methods
.method public a(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lchat/ola/vn/entry/a/b;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lchat/ola/vn/b/b;->b:Ljava/util/List;

    return-void
.end method

.method public getChild(II)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/b;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/a/b;

    invoke-virtual {p1, p2}, Lchat/ola/vn/entry/a/b;->a(I)Lchat/ola/vn/entry/a/c;

    move-result-object p1

    return-object p1
.end method

.method public getChildId(II)J
    .locals 0

    invoke-static {p1, p2}, Landroid/widget/ExpandableListView;->getPackedPositionForChild(II)J

    move-result-wide p1

    return-wide p1
.end method

.method public getChildView(IIZLandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 1

    if-nez p4, :cond_0

    iget-object p4, p0, Lchat/ola/vn/b/b;->a:Landroid/view/LayoutInflater;

    const p5, 0x7f0b001f

    const/4 v0, 0x0

    invoke-virtual {p4, p5, v0}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p4

    new-instance p5, Lchat/ola/vn/b/b$a;

    invoke-direct {p5, p0, p4}, Lchat/ola/vn/b/b$a;-><init>(Lchat/ola/vn/b/b;Landroid/view/View;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p4}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p5

    check-cast p5, Lchat/ola/vn/b/b$a;

    :goto_0
    :try_start_0
    invoke-virtual {p0, p1, p2}, Lchat/ola/vn/b/b;->getChild(II)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/a/c;

    invoke-virtual {p5, p1}, Lchat/ola/vn/b/b$a;->a(Lchat/ola/vn/entry/a/c;)V

    if-eqz p3, :cond_1

    const p1, 0x7f0800a9

    invoke-virtual {p4, p1}, Landroid/view/View;->setBackgroundResource(I)V

    return-object p4

    :cond_1
    const p1, 0x7f0800a8

    invoke-virtual {p4, p1}, Landroid/view/View;->setBackgroundResource(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p4

    :catch_0
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    return-object p4
.end method

.method public getChildrenCount(I)I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/b;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/a/b;

    invoke-virtual {p1}, Lchat/ola/vn/entry/a/b;->b()I

    move-result p1

    return p1
.end method

.method public getGroup(I)Ljava/lang/Object;
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/b;->b:Ljava/util/List;

    invoke-interface {v0, p1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method

.method public getGroupCount()I
    .locals 1

    iget-object v0, p0, Lchat/ola/vn/b/b;->b:Ljava/util/List;

    if-nez v0, :cond_0

    const/4 v0, 0x0

    return v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/b/b;->b:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    return v0
.end method

.method public getGroupId(I)J
    .locals 2

    invoke-static {p1}, Landroid/widget/ExpandableListView;->getPackedPositionForGroup(I)J

    move-result-wide v0

    return-wide v0
.end method

.method public getGroupView(IZLandroid/view/View;Landroid/view/ViewGroup;)Landroid/view/View;
    .locals 0

    if-nez p3, :cond_0

    iget-object p2, p0, Lchat/ola/vn/b/b;->a:Landroid/view/LayoutInflater;

    const p3, 0x7f0b001e

    const/4 p4, 0x0

    invoke-virtual {p2, p3, p4}, Landroid/view/LayoutInflater;->inflate(ILandroid/view/ViewGroup;)Landroid/view/View;

    move-result-object p3

    new-instance p2, Lchat/ola/vn/b/b$b;

    invoke-direct {p2, p0, p3}, Lchat/ola/vn/b/b$b;-><init>(Lchat/ola/vn/b/b;Landroid/view/View;)V

    goto :goto_0

    :cond_0
    invoke-virtual {p3}, Landroid/view/View;->getTag()Ljava/lang/Object;

    move-result-object p2

    check-cast p2, Lchat/ola/vn/b/b$b;

    :goto_0
    iget-object p2, p2, Lchat/ola/vn/b/b$b;->a:Landroid/widget/TextView;

    invoke-virtual {p0, p1}, Lchat/ola/vn/b/b;->getGroup(I)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lchat/ola/vn/entry/a/b;

    invoke-virtual {p1}, Lchat/ola/vn/entry/a/b;->a()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    return-object p3
.end method

.method public hasStableIds()Z
    .locals 1

    const/4 v0, 0x0

    return v0
.end method

.method public isChildSelectable(II)Z
    .locals 0

    const/4 p1, 0x1

    return p1
.end method
