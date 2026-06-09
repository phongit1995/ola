.class Lcom/mg/ola/common/widget/image/viewer/d$a;
.super Lcom/mg/ola/common/widget/image/viewer/d;


# annotations
.annotation build Landroid/annotation/TargetApi;
    value = 0x9
.end annotation

.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/mg/ola/common/widget/image/viewer/d;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "a"
.end annotation


# instance fields
.field private a:Landroid/widget/OverScroller;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 1

    invoke-direct {p0}, Lcom/mg/ola/common/widget/image/viewer/d;-><init>()V

    new-instance v0, Landroid/widget/OverScroller;

    invoke-direct {v0, p1}, Landroid/widget/OverScroller;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/d$a;->a:Landroid/widget/OverScroller;

    return-void
.end method


# virtual methods
.method public a(IIIIIIIIII)V
    .locals 12

    move-object v0, p0

    iget-object v1, v0, Lcom/mg/ola/common/widget/image/viewer/d$a;->a:Landroid/widget/OverScroller;

    move v2, p1

    move v3, p2

    move v4, p3

    move/from16 v5, p4

    move/from16 v6, p5

    move/from16 v7, p6

    move/from16 v8, p7

    move/from16 v9, p8

    move/from16 v10, p9

    move/from16 v11, p10

    invoke-virtual/range {v1 .. v11}, Landroid/widget/OverScroller;->fling(IIIIIIIIII)V

    return-void
.end method

.method public a(Z)V
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/d$a;->a:Landroid/widget/OverScroller;

    invoke-virtual {v0, p1}, Landroid/widget/OverScroller;->forceFinished(Z)V

    return-void
.end method

.method public a()Z
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/d$a;->a:Landroid/widget/OverScroller;

    invoke-virtual {v0}, Landroid/widget/OverScroller;->computeScrollOffset()Z

    move-result v0

    return v0
.end method

.method public b()I
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/d$a;->a:Landroid/widget/OverScroller;

    invoke-virtual {v0}, Landroid/widget/OverScroller;->getCurrX()I

    move-result v0

    return v0
.end method

.method public c()I
    .locals 1

    iget-object v0, p0, Lcom/mg/ola/common/widget/image/viewer/d$a;->a:Landroid/widget/OverScroller;

    invoke-virtual {v0}, Landroid/widget/OverScroller;->getCurrY()I

    move-result v0

    return v0
.end method
