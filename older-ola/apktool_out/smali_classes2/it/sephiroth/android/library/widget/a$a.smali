.class public Lit/sephiroth/android/library/widget/a$a;
.super Ljava/lang/Object;

# interfaces
.implements Landroid/view/ContextMenu$ContextMenuInfo;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lit/sephiroth/android/library/widget/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "a"
.end annotation


# instance fields
.field public a:Landroid/view/View;

.field public b:I

.field public c:J


# direct methods
.method public constructor <init>(Landroid/view/View;IJ)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lit/sephiroth/android/library/widget/a$a;->a:Landroid/view/View;

    iput p2, p0, Lit/sephiroth/android/library/widget/a$a;->b:I

    iput-wide p3, p0, Lit/sephiroth/android/library/widget/a$a;->c:J

    return-void
.end method
