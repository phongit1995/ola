.class public Landroid/support/v7/widget/TooltipCompat;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Landroid/support/v7/widget/TooltipCompat$Api26ViewCompatImpl;,
        Landroid/support/v7/widget/TooltipCompat$BaseViewCompatImpl;,
        Landroid/support/v7/widget/TooltipCompat$ViewCompatImpl;
    }
.end annotation


# static fields
.field private static final IMPL:Landroid/support/v7/widget/TooltipCompat$ViewCompatImpl;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I

    const/4 v1, 0x0

    const/16 v2, 0x1a

    if-lt v0, v2, :cond_0

    new-instance v0, Landroid/support/v7/widget/TooltipCompat$Api26ViewCompatImpl;

    invoke-direct {v0, v1}, Landroid/support/v7/widget/TooltipCompat$Api26ViewCompatImpl;-><init>(Landroid/support/v7/widget/TooltipCompat$1;)V

    :goto_0
    sput-object v0, Landroid/support/v7/widget/TooltipCompat;->IMPL:Landroid/support/v7/widget/TooltipCompat$ViewCompatImpl;

    return-void

    :cond_0
    new-instance v0, Landroid/support/v7/widget/TooltipCompat$BaseViewCompatImpl;

    invoke-direct {v0, v1}, Landroid/support/v7/widget/TooltipCompat$BaseViewCompatImpl;-><init>(Landroid/support/v7/widget/TooltipCompat$1;)V

    goto :goto_0

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static setTooltipText(Landroid/view/View;Ljava/lang/CharSequence;)V
    .locals 1
    .param p0    # Landroid/view/View;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param
    .param p1    # Ljava/lang/CharSequence;
        .annotation build Landroid/support/annotation/Nullable;
        .end annotation
    .end param

    sget-object v0, Landroid/support/v7/widget/TooltipCompat;->IMPL:Landroid/support/v7/widget/TooltipCompat$ViewCompatImpl;

    invoke-interface {v0, p0, p1}, Landroid/support/v7/widget/TooltipCompat$ViewCompatImpl;->setTooltipText(Landroid/view/View;Ljava/lang/CharSequence;)V

    return-void
.end method
